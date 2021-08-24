resource "aws_key_pair" "elrr_public" {
  key_name = "elrr_public"
  public_key = file("elrr_public.pub")
  }

resource "aws_key_pair" "elrr_private" {
  key_name = "elrr_private"
  public_key = file("elrr_private.pub")
  }
