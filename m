Return-Path: <linux-can+bounces-5441-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B530C608D7
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 17:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BEB14E1393
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 16:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97A2221FBD;
	Sat, 15 Nov 2025 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="dTmQddQr";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Kgq9+xbc"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C94123BF8F
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763224999; cv=pass; b=hvVevKYCNfPoJqBs2V8d2D+9NU6PrY0L0fH4MwWQybctZiO4NiW65bSd0gL2g3RuYlcGQECvCjdvVi9GeANU308rbDKWR/LJWfeTehUgP8PqKNQqLL3eeJNhYbShWFsKJTSrQo1SSUpsLyypC44a5j42T6nsyB1Xxxi9A78avMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763224999; c=relaxed/simple;
	bh=0fHnvEd4zamRkIBf54JJ3Wibbb+FIjB0X+fCozPzM4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=td3yP3FLtkrTJL2Bc3jvxk4wWX0/UWUO5b2shZdpYrilzOgf5inpSA/g1qIXZ29C38yzACSEnHXHH98Q9DAWN4cDkjbjf/sCPLtJCy2WjhdwZ8m7PGL1hRbf/kwDIhC/UK2qsdCnTRKUUUh9qiXwN0Vb80w91sS6OLFrzIQWfJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=dTmQddQr; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Kgq9+xbc; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763224989; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=aj8q1FxLIHDtYGdzt65aYg7ZJQ4A/+GG8WrXA85KJgb2c3wIormJ9Q/ty9EM47IGDw
    5xZOI8DUUhInaSlwRwq1TlZpVKpU9owyM0GbwWsV/vOGWc/tUpSdT3R7nKP7aC+jF7Wv
    x2IudLDly3qFA3kPxa5GJnMXAeiBYFaRCwInTrdMpFbb4kHbWZ5yKUiUN6mjhxgmI7js
    /8mIIjFrq78wTB5CE05yjno+xwXoHpmQOpXiadS/dYPTT4roRBi8F31CXaHN0SsHrCUU
    QcGiMy0yjI5Y/niQ2J9wkO92ZIoBkNNQdaZaj5t4AdbkVF40nFdoWSSsMNy38cOONLAC
    x4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224989;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=RZ2LxykQuf07n6aKoZJI2cGvR+ZeJPLM+YVDZxlKWSc=;
    b=Y3YlOLo2eefa04uMuRlcZHmOLytJH5mJsEoR9uSm5qlK7bs2GiaWKCm4zV3WrbRC2b
    +sfT2xwHhiic8MmVuiSpe1PveMOiCH5lUymJn8pLajExT/PBZN2gVSM8BGE+susYTB6a
    ce27sRevRrXY88hsvBMDvetjP/+stUmk6xX+PGEdWlRbaU7vOQEmZVXU+AQOMXJNPLbQ
    v28GQsvHYXMLzviTGUIUzBcVpmbTCBjI9wEdxuTMhqpnTEwHM0dYhRf5J+0VjoedyFAU
    YTU7VbU21VWIdb4DMEQnFrHstXckQMhpgX/CZX375+0Uy8UhREKwRaH+Y7wmm/gN/EBK
    KsLw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224989;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=RZ2LxykQuf07n6aKoZJI2cGvR+ZeJPLM+YVDZxlKWSc=;
    b=dTmQddQrlYtcFGdxqneb73gNTeorb2KncP2d9ph95Cerg3OY6qceT/IUsoZPufF4iY
    jA2aGoE+YowSoNZMg65SAGS3YgYBY7Ug2oXTBOONnnqK0UsDNawgY8x+z3Tr1F7RU/4W
    XPTadC0g6+wRZKXq+8bKhvVDa10Xn16rHOaj2W6HIxSoNKKfQV03eoQLm1F8eGJutRKN
    VqJ/PnOYxPSVViH6vgthh2RNq5Hf/kUr2jw7CanTnqc1I6X/hFlJvYvbGsBrx7dOHMZ+
    1FJgGOPacxH85nGLPY3gwu+zth8ddeU4Xh3eLCcXfcJnjfcUewIcR44qQZoC0py+wQam
    MR7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763224989;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=RZ2LxykQuf07n6aKoZJI2cGvR+ZeJPLM+YVDZxlKWSc=;
    b=Kgq9+xbcLdyJnY+fs2DlMVwnXh2Lp08uuS4AK25jFLuFbRjTX2bacuL9FMtmTmm8yo
    mdgbi625O18mthS1RUAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFGh9eRg
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 17:43:09 +0100 (CET)
Message-ID: <d7a5a417-18cd-43b8-a4d2-84da49d8f2c3@hartkopp.net>
Date: Sat, 15 Nov 2025 17:43:03 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: sja1000: fix max irq loop handling
To: =?UTF-8?Q?Thomas_M=C3=BChlbacher?= <tmuehlbacher@posteo.net>,
 linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
References: <20251115153437.11419-1-tmuehlbacher@posteo.net>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251115153437.11419-1-tmuehlbacher@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15.11.25 16:34, Thomas Mühlbacher wrote:
> Reading the interrupt register `SJA1000_IR` causes all of its bits to be
> reset. If we ever reach the condition of handling more than
> `SJA1000_MAX_IRQ` IRQs, we will have read the register and reset all its
> bits but without actually handling the interrupt inside of the loop
> body.
> 
> This may, among other issues, cause us to never `netif_wake_queue()`
> again after a transmission interrupt.
> 
> Fixes: 429da1cc841b ("can: Driver for the SJA1000 CAN controller")
> Signed-off-by: Thomas Mühlbacher <tmuehlbacher@posteo.net>

Good catch in this ~20 yo code!

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks Thomas!

> ---
>   drivers/net/can/sja1000/sja1000.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
> index 4d245857ef1c..83476af8adb5 100644
> --- a/drivers/net/can/sja1000/sja1000.c
> +++ b/drivers/net/can/sja1000/sja1000.c
> @@ -548,8 +548,8 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
>   	if (priv->read_reg(priv, SJA1000_IER) == IRQ_OFF)
>   		goto out;
>   
> -	while ((isrc = priv->read_reg(priv, SJA1000_IR)) &&
> -	       (n < SJA1000_MAX_IRQ)) {
> +	while ((n < SJA1000_MAX_IRQ) &&
> +	       (isrc = priv->read_reg(priv, SJA1000_IR))) {
>   
>   		status = priv->read_reg(priv, SJA1000_SR);
>   		/* check for absent controller due to hw unplug */


