Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A05A3E52F6
	for <lists+linux-can@lfdr.de>; Tue, 10 Aug 2021 07:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbhHJFe3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 10 Aug 2021 01:34:29 -0400
Received: from smtp-16-i2.italiaonline.it ([213.209.12.16]:40990 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236481AbhHJFe2 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 10 Aug 2021 01:34:28 -0400
Received: from oxapps-11-063.iol.local ([10.101.8.73])
        by smtp-16.iol.local with ESMTPA
        id DKOrmHojZNAOdDKOrmZ1Bb; Tue, 10 Aug 2021 07:34:05 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1628573645; bh=JMxweIV1r1BetrnL0LcaNchdA/T8X+41xtfojuq2Xj0=;
        h=From;
        b=Z1RLkq6RvPsSjhZjyfry4hqeGjQs/QClzu33V4z/SEGMMjVn6+GokWWBMr/PKwnHl
         uHtmk6H1Utgkrk7OUx0+AHhq21p6b4yAA6lx9+acBDV4C6xWEXxAsvstIrynx7KG2y
         4/EV/UVIb1nrsNqrUCsx/en7jpZr1FZ3rm4RpmHF4UES7YIEW3ccaf5XPw7QZxG/Pf
         C1pNihjdJdyaPKfrijFyOfx1PDk2YGN5viOQSbkKiBtQoFgEPDs8Qmsksm0TlOhO/8
         V4HQ0VaWfhhBfj4bm1akkQynoy1XpnQrzfrJv+ERdDiZE8sx1C8VDESKz2PBPE0Gf0
         CniL9Y+N1i2Mg==
X-CNFS-Analysis: v=2.4 cv=FoLAQ0nq c=1 sm=1 tr=0 ts=61120fcd cx=a_exe
 a=mMekBfHVlu8C64H7xmYZHA==:117 a=53-0AmxBnkoA:10 a=IkcTkHD0fZMA:10
 a=XmJMGle_k8YA:10 a=US0YOg7qL0DOt7DS0ekA:9 a=QEXdDO2ut3YA:10
Date:   Tue, 10 Aug 2021 07:34:05 +0200 (CEST)
From:   Dario Binacchi <dariobin@libero.it>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Message-ID: <384767683.303063.1628573645349@mail1.libero.it>
In-Reply-To: <20210809080608.171545-1-mkl@pengutronix.de>
References: <20210809080608.171545-1-mkl@pengutronix.de>
Subject: Re: [PATCH] can: c_can: rename IF_RX -> IF_NAPI
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.3-Rev34
X-Originating-IP: 5.90.110.159
X-Originating-Client: open-xchange-appsuite
x-libjamsun: 7sBD9cYHmJaZJvp+DukmNcRXlCu/vApK
x-libjamv: 4eSgXx2vbbA=
X-CMAE-Envelope: MS4xfFp1rGMPo3sNxl9SnTRjArol2wA4L7Rbt2r2M5Si9Yman2tU312YbMKxJUnUfYJ1rStaCAujgY0oZN4ZBNQoIUtccPxHFE/81OYzkKIw6Fd/HYWjkkmf
 f8SE6txyseVMEyDSKsOGdfw+/R2DG1xTFiD89BPV9hFA79SjSwhktMk8EJYhEDs+iupcI+TbIM2rKNJjGLSxmwOKoNVsFbT48K1YBwMUmjdQBCJ0usKPowJu
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

> Il 09/08/2021 10:06 Marc Kleine-Budde <mkl@pengutronix.de> ha scritto:
> 
>  
> The C_CAN/D_CAN cores implement 2 interfaces to manage the message
> objects. To avoid concurrency and the need for locking one interface
> is used in the TX path (IF_TX). While the other one, named IF_RX is
> used from NAPI context only. As this interface is not only used to
> manage RX, but also TX message objects, this patch renames IF_RX to
> IF_NAPI.
> 
> Cc: Dario Binacchi <dariobin@libero.it>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Hey Dario,
> 
> as promised a patch to rename IF_RX -> IF_NAPI.
>

I agree with you. It's the right choice.
Thanks and regards,
Dario
 
> In my current patch stack, I've added this patch before your FIFO
> changes (and updated your patch accordingly), to avoid changing the
> newly added IF_RX in your patch to IF_NAPI in the next patch.
> 
> regards,
> Marc
> 
>  drivers/net/can/c_can/c_can_main.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
> index e65bd7a9cf1d..a3c2d9ec90f9 100644
> --- a/drivers/net/can/c_can/c_can_main.c
> +++ b/drivers/net/can/c_can/c_can_main.c
> @@ -161,7 +161,7 @@
>  #define IF_MCONT_TX		(IF_MCONT_TXIE | IF_MCONT_EOB)
>  
>  /* Use IF1 for RX and IF2 for TX */
> -#define IF_RX			0
> +#define IF_NAPI			0
>  #define IF_TX			1
>  
>  /* minimum timeout for checking BUSY status */
> @@ -529,13 +529,13 @@ static void c_can_configure_msg_objects(struct net_device *dev)
>  
>  	/* first invalidate all message objects */
>  	for (i = priv->msg_obj_rx_first; i <= priv->msg_obj_num; i++)
> -		c_can_inval_msg_object(dev, IF_RX, i);
> +		c_can_inval_msg_object(dev, IF_NAPI, i);
>  
>  	/* setup receive message objects */
>  	for (i = priv->msg_obj_rx_first; i < priv->msg_obj_rx_last; i++)
> -		c_can_setup_receive_object(dev, IF_RX, i, 0, 0, IF_MCONT_RCV);
> +		c_can_setup_receive_object(dev, IF_NAPI, i, 0, 0, IF_MCONT_RCV);
>  
> -	c_can_setup_receive_object(dev, IF_RX, priv->msg_obj_rx_last, 0, 0,
> +	c_can_setup_receive_object(dev, IF_NAPI, priv->msg_obj_rx_last, 0, 0,
>  				   IF_MCONT_RCV_EOB);
>  }
>  
> @@ -710,11 +710,11 @@ static void c_can_do_tx(struct net_device *dev)
>  		pend &= ~BIT(idx);
>  		obj = idx + priv->msg_obj_tx_first;
>  
> -		/* We use IF_RX interface instead of IF_TX because we
> +		/* We use IF_NAPI interface instead of IF_TX because we
>  		 * are called from c_can_poll(), which runs inside
>  		 * NAPI. We are not transmitting.
>  		 */
> -		c_can_inval_tx_object(dev, IF_RX, obj);
> +		c_can_inval_tx_object(dev, IF_NAPI, obj);
>  		can_get_echo_skb(dev, idx, NULL);
>  		bytes += priv->dlc[idx];
>  		pkts++;
> @@ -766,14 +766,14 @@ static u32 c_can_adjust_pending(u32 pend, u32 rx_mask)
>  static inline void c_can_rx_object_get(struct net_device *dev,
>  				       struct c_can_priv *priv, u32 obj)
>  {
> -	c_can_object_get(dev, IF_RX, obj, priv->comm_rcv_high);
> +	c_can_object_get(dev, IF_NAPI, obj, priv->comm_rcv_high);
>  }
>  
>  static inline void c_can_rx_finalize(struct net_device *dev,
>  				     struct c_can_priv *priv, u32 obj)
>  {
>  	if (priv->type != BOSCH_D_CAN)
> -		c_can_object_get(dev, IF_RX, obj, IF_COMM_CLR_NEWDAT);
> +		c_can_object_get(dev, IF_NAPI, obj, IF_COMM_CLR_NEWDAT);
>  }
>  
>  static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
> @@ -785,10 +785,12 @@ static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
>  		pend &= ~BIT(obj - 1);
>  
>  		c_can_rx_object_get(dev, priv, obj);
> -		ctrl = priv->read_reg(priv, C_CAN_IFACE(MSGCTRL_REG, IF_RX));
> +		ctrl = priv->read_reg(priv, C_CAN_IFACE(MSGCTRL_REG, IF_NAPI));
>  
>  		if (ctrl & IF_MCONT_MSGLST) {
> -			int n = c_can_handle_lost_msg_obj(dev, IF_RX, obj, ctrl);
> +			int n;
> +
> +			n = c_can_handle_lost_msg_obj(dev, IF_NAPI, obj, ctrl);
>  
>  			pkts += n;
>  			quota -= n;
> @@ -803,7 +805,7 @@ static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
>  			continue;
>  
>  		/* read the data from the message object */
> -		c_can_read_msg_object(dev, IF_RX, ctrl);
> +		c_can_read_msg_object(dev, IF_NAPI, ctrl);
>  
>  		c_can_rx_finalize(dev, priv, obj);
>  
> -- 
> 2.30.2
