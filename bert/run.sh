#!/bin/sh
#SBATCH --account=es_bambach
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --gpus-per-node=rtx_3090:1 # we have 4x 3090 and 4x 4090
#SBATCH --gres=gpumem:24
#SBATCH -o outfile_runs  # send stdout to outfile
#SBATCH -e errfile_runs  # send stderr to errfile
#SBATCH --mem-per-cpu=4g
#SBATCH -t 00:01:00  # time requested in hour:minute:second
python run_classifier.py   --task_name bert  --do_train --do_eval   --data_dir .   --vocab_file $BERT_BASE_DIR/vocab.txt   --bert_config_file $BERT_BASE_DIR/bert_config.json   --init_checkpoint $BERT_BASE_DIR/pytorch_model.bin   --max_seq_length 512   --train_batch_size 24   --learning_rate 3e-5   --num_train_epochs 20.0   --output_dir bert_f1  --gradient_accumulation_steps 2