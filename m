Return-Path: <linux-can+bounces-2083-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D50349D0B2C
	for <lists+linux-can@lfdr.de>; Mon, 18 Nov 2024 09:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61464B21B91
	for <lists+linux-can@lfdr.de>; Mon, 18 Nov 2024 08:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5E523A9;
	Mon, 18 Nov 2024 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="CbTPNEBf";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="iIjH0tOH"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5955C1487D5
	for <linux-can@vger.kernel.org>; Mon, 18 Nov 2024 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731919550; cv=pass; b=A7300FxWlOYF89Q02jfLR+KeTiTdbcFx7R75ijPrS1x9a50EOSu8SXMMOlkV+kt0/MrY7ydqa0Q0J5W2BRqicP4NQ4p6FIFAOcDM6CmMgpqgRc8xRm25dreMPPNA2C1fYGzGEnBYaOP1btT+XWBs++zMcK95qyaa+gr8ZOY86wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731919550; c=relaxed/simple;
	bh=pPjRe1TCubhIRTcRUFD1JgpGZpEkUVCnEtOaoZIOMg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PymvnDtjSdPevm7gSoTjAWyWQ+NxtQbAOxOZsK9HtgR0WL9h9hCxN9d+G6Y9vnq4Qkh2/PJ0SnfzbAaiLVpdklcrN0b3l6y67Dp0raygpDC2GKKpAK7Epfc5hMqxezPuOlEB7GAuN5T+ui7x3PIHLhh1KZxz+7ZmnVwAtz3QE8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=CbTPNEBf; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=iIjH0tOH; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1731919174; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VWG8e/cy6n+M1B/MTxR2kkDkQm2OVGRAiBESbEuS/q3DO+ljVPDqjYkw82zzoI58PS
    2jiLR9vs/b93t/xXpPl+rWkiTHz9FLJFATc8E2xsiBU6vkngFj3W9zfN+akWLAARRVE9
    8RAULe9tcollDwG0w7nShNJiC91dGoH2Swp8j9AZMLJ1KpWBdJONvrcGqHJfZHxYjpw9
    U4f5W12qZAe6G/rMPAd6LwlqNC6bFuFPpoAO5FGeeh0ukEEJmdno/hzMRmboVxRoy3xd
    4OKl3jjT9+25o17kfipwCCC1Nj5baw4h9aDSk71ALGyLdtZf/iHg6HuKP2akNhzoBA+G
    VNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1731919174;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=l2BODKNHPqPSeEYFcmiPWDZAem9VaGzWOqMDzXXBeJs=;
    b=pm+TQfi2hcpGgH4HVAjwu4W+XNd8DkDyxg4+aUDSoXYmgsc7mnxEwVwFXcj1kmsNam
    zZA21DXdDTnJWeCuVp4+eFjr+TZ7d855Jgt39c4298Ci8ur8G5ULkK1YMRAy2Fdv2uXN
    4K21SGqbJ87BwOZIzddbw9KbEoO6VZ+fcF/k4T+xKFU4MFFGwY2bjc6aayRdYrdfAyIS
    FNM2Az/T3FOlX05GzBhkt2R2TMEe6uDX6QySDfjtlc0FB1pxtoBzRbO75c8/8Ghftsbn
    Z1fIuANDuUwzYicdwBycV9xkAQbb57uTTVi7PtIhGAEqFfmyArNlbXmmaJ/+7elfFnuw
    WJVg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1731919174;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=l2BODKNHPqPSeEYFcmiPWDZAem9VaGzWOqMDzXXBeJs=;
    b=CbTPNEBfcGLyYDs5zmWgKH6KF+xlA9gqdTfFQ9zHnHSEwrD4Yn8yscAp7+wMkvc5pE
    frQ7DoJmSbwiAWGcf3So1ZCYOIJyBe5vsUwmSh7cHi2oDm7GLYU8X3fceISqbu+DY1iW
    EGTP9MjmfAMlvtfBN9yPxIGxfEJz3i6OIfFf2ruplBeYqIWjp5YWXF2XrcOqP7QP7w1F
    4Tg2IPMa4sHn2jLxJ/aQd+PAv0vjgt6hI5IZdQtT1dmlODRy095EkbfLqV3iDiBnoq6q
    ZYUZddIyKOM+hYwssr74ciGIk/2rJ8J6udI7/LAjw4U8nlVmSX+oawQbFaD0/aOJDh+A
    U5uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1731919174;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=l2BODKNHPqPSeEYFcmiPWDZAem9VaGzWOqMDzXXBeJs=;
    b=iIjH0tOH8Ag9nOaqyVPPueqINaFBhW+mZGgDBv91EtcH6r5T2eIyZ9Uc1TZYKE0Edn
    SmnpN36ZrWcz3pzJHiBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id K63ada0AI8dXeFf
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 18 Nov 2024 09:39:33 +0100 (CET)
Message-ID: <9d43985d-fc25-4f51-b339-d5dcd33b666d@hartkopp.net>
Date: Mon, 18 Nov 2024 09:39:27 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] can: f81604: fix {rx,tx}_errors statistics
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-amarula@amarulasolutions.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>,
 "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>,
 linux-can@vger.kernel.org
References: <20241116180301.3935879-1-dario.binacchi@amarulasolutions.com>
 <20241116180301.3935879-8-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20241116180301.3935879-8-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

-netdev ML

Hello Dario,

thanks for taking a look on the error statistics.

As an example for my following remark I picked this patch.

On 16.11.24 19:02, Dario Binacchi wrote:
> The f81604_handle_can_bus_errors() function only incremented the receive
> error counter and never the transmit error counter, even if the ECC_DIR
> flag reported that an error had occurred during transmission. The patch
> increments the receive/transmit error counter based on the value of the
> ECC_DIR flag.
> 
> Fixes: 88da17436973 ("can: usb: f81604: add Fintek F81604 support")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
>   drivers/net/can/usb/f81604.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
> index bc0c8903fe77..8463e00517c9 100644
> --- a/drivers/net/can/usb/f81604.c
> +++ b/drivers/net/can/usb/f81604.c
> @@ -526,7 +526,6 @@ static void f81604_handle_can_bus_errors(struct f81604_port_priv *priv,
>   		netdev_dbg(netdev, "bus error interrupt\n");
>   
>   		priv->can.can_stats.bus_error++;
> -		stats->rx_errors++;
>   
>   		if (skb) {

The statistics are updated only if we successfully allocated a skbuff 
for the error message frame.

>   			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
> @@ -550,8 +549,12 @@ static void f81604_handle_can_bus_errors(struct f81604_port_priv *priv,
>   			cf->data[3] = data->ecc & F81604_SJA1000_ECC_SEG;
>   
>   			/* Error occurred during transmission? */
> -			if ((data->ecc & F81604_SJA1000_ECC_DIR) == 0)
> +			if ((data->ecc & F81604_SJA1000_ECC_DIR) == 0) {
>   				cf->data[2] |= CAN_ERR_PROT_TX;
> +				stats->tx_errors++;
> +			} else {
> +				stats->rx_errors++;
> +			}
>   		}
>   
>   		set_bit(F81604_CLEAR_ECC, &priv->clear_flags);

Is this a good approach or should we always update the statistics 
independently of the potential failure of the skbuff allocation?

Best regards,
Oliver

