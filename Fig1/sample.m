function [sample_] = sample(mean_, sd_)

sample_ = mean_ + sd_.*randn(1,1);

end

