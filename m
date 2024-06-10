Return-Path: <linux-can+bounces-720-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9279028B8
	for <lists+linux-can@lfdr.de>; Mon, 10 Jun 2024 20:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713F81C21151
	for <lists+linux-can@lfdr.de>; Mon, 10 Jun 2024 18:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66DF14A615;
	Mon, 10 Jun 2024 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZjapAPR"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8723226AF6;
	Mon, 10 Jun 2024 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718044481; cv=none; b=kzwcN9gCjh7F4Kqj9LeNptIr8WmIABMJcGavBKv4rdfCfzmpLRJQRMyVmJnfBb2jy5RQLlBXATwAEalIGtm672tOLgN61llKd4ukHH3rlBqLI12aRgJwpbkPlDU4RDuFXek5L4LisqF7TxmWu67CIPeJe1liEWDF0TiCO5cA69c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718044481; c=relaxed/simple;
	bh=EQK/KV6JGQCcaQIumxe+c3ZiCtBTee+Hya5VKlTW9Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDODOo6ErRfqWWaLR/Oj9s2RqNMX4XHIwqASUhpDJ7NPYjTd7JBuyyO6RKQh6nqIqsFzkj9LlkBIEbxIJ6cYQ7iBt6jTJ0NLyuep3VjdkONLD5XhE4TYPQD2UNpp8wuZHOxXzt4mUqFO9kgsLeTDcVHRbKgtTnx/BX91NTBD77U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZjapAPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF04C2BBFC;
	Mon, 10 Jun 2024 18:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718044481;
	bh=EQK/KV6JGQCcaQIumxe+c3ZiCtBTee+Hya5VKlTW9Yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OZjapAPR1ixL81ZHUa5DxgMQ/S+YnKJNY/0w1g17WfsUbr72X7n7QbQwlh2pPPudv
	 Zsgyfyo4CTfm75nvWRIiIcYrbVOt1L5C9p56puNEgZyCjNGtki+ccAUSmXFnXrYL9Y
	 u4FyxlcdrYJ9x5oE0f63i+HrV1QAezZf3NckpFCblfRuJulhQsK3SiS7BZ2u0rz3d9
	 ok6NGBC4IC/Se58w7EmjiFteg1E4FjdZipF02iKfy96Ts9rBfLDC9d7O4DBZiLDVCR
	 oGpKuSXhA1ghcF3KNDzKouqY0DY3m6qg5BlmlL7+w2iSSRsXGMsb5T/D5N4VMn+kgA
	 hLn/atADylknQ==
Date: Mon, 10 Jun 2024 11:34:40 -0700
From: Kees Cook <kees@kernel.org>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] can: peak_canfd: decorate pciefd_board.can with
 __counted_by()
Message-ID: <202406101128.C7BEF1F@keescook>
References: <20240609045419.240265-1-mailhol.vincent@wanadoo.fr>
 <20240609045419.240265-2-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609045419.240265-2-mailhol.vincent@wanadoo.fr>

On Sun, Jun 09, 2024 at 01:54:18PM +0900, Vincent Mailhol wrote:
> A new __counted_by() attribute was introduced in [1]. It makes the
> compiler's sanitizer aware of the actual size of a flexible array
> member, allowing for additional runtime checks.
> 
> Move the end of line comments to the previous line to make room and
> apply the __counted_by() attribute to the can flexible array member of
> struct pciefd_board.
> 
> [1] commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro")
> Link: https://git.kernel.org/torvalds/c/dd06e72e68bc
> 
> CC: Kees Cook <kees@kernel.org>
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>  drivers/net/can/peak_canfd/peak_pciefd_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/peak_canfd/peak_pciefd_main.c b/drivers/net/can/peak_canfd/peak_pciefd_main.c
> index 1df3c4b54f03..636102103a88 100644
> --- a/drivers/net/can/peak_canfd/peak_pciefd_main.c
> +++ b/drivers/net/can/peak_canfd/peak_pciefd_main.c
> @@ -190,8 +190,10 @@ struct pciefd_board {
>  	void __iomem *reg_base;
>  	struct pci_dev *pci_dev;
>  	int can_count;
> -	spinlock_t cmd_lock;		/* 64-bits cmds must be atomic */
> -	struct pciefd_can *can[];	/* array of network devices */
> +	/* 64-bits cmds must be atomic */
> +	spinlock_t cmd_lock;
> +	/* array of network devices */
> +	struct pciefd_can *can[] __counted_by(can_count);
>  };
>  
>  /* supported device ids. */

You'll need to adjust the code logic that manipulates "can_count", as
accesses to "can" will trap when they're seen as out of bounds. For
example:

        pciefd = devm_kzalloc(&pdev->dev, struct_size(pciefd, can, can_count),
                              GFP_KERNEL);
	...
	/* pciefd->can_count is "0" now */


        while (pciefd->can_count < can_count) {
		...
                pciefd_can_probe(pciefd);
		/* which does: */
        		pciefd->can[pciefd->can_count] = priv;	/// HERE
		...
                pciefd->can_count++;
	}

The access at "HERE" above will trap: "can" is believed to have
"can_count" elements (0 on the first time through the loop).
This needs to be adjusted to increment "can_count" first.

Perhaps:


diff --git a/drivers/net/can/peak_canfd/peak_pciefd_main.c b/drivers/net/can/peak_canfd/peak_pciefd_main.c
index 1df3c4b54f03..df8304b2d291 100644
--- a/drivers/net/can/peak_canfd/peak_pciefd_main.c
+++ b/drivers/net/can/peak_canfd/peak_pciefd_main.c
@@ -676,7 +676,8 @@ static int pciefd_can_probe(struct pciefd_board *pciefd)
 	spin_lock_init(&priv->tx_lock);
 
 	/* save the object address in the board structure */
-	pciefd->can[pciefd->can_count] = priv;
+	pciefd->can_count++;
+	pciefd->can[pciefd->can_count - 1] = priv;
 
 	dev_info(&pciefd->pci_dev->dev, "%s at reg_base=0x%p irq=%d\n",
 		 ndev->name, priv->reg_base, ndev->irq);
@@ -800,8 +801,6 @@ static int peak_pciefd_probe(struct pci_dev *pdev,
 		err = pciefd_can_probe(pciefd);
 		if (err)
 			goto err_free_canfd;
-
-		pciefd->can_count++;
 	}
 
 	/* set system timestamps counter in RST mode */


-- 
Kees Cook

