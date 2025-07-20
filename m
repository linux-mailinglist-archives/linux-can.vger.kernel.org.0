Return-Path: <linux-can+bounces-4008-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FAEB0B38C
	for <lists+linux-can@lfdr.de>; Sun, 20 Jul 2025 06:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1BB7189C5AD
	for <lists+linux-can@lfdr.de>; Sun, 20 Jul 2025 04:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E6817B4EC;
	Sun, 20 Jul 2025 04:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Me6ZcTGr"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-72.smtpout.orange.fr [193.252.22.72])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50BED299;
	Sun, 20 Jul 2025 04:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752987065; cv=none; b=nY4xpaGfULOnMPthlPrDTCVm2mAdzVcA8tR36NAieeAnvD7kTvPNML3VSiwGbjqJxFkBHQwM5DNFkWuD3MXDuizO8cVuxMPx56IeHrVjOzsbVNVevK6UwoV/nulTYatVMDtboggvaxF7Jmrrca2XqiJFTeEDI+UAZ4PBHs45vmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752987065; c=relaxed/simple;
	bh=X2VRJTxNQyY91tfVK/IAKHg5Xsb8+sJWzkjkXodWz/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WXq1x6HMzxhvIWrM+Q/lpGiMml0OPe7FWA3ZCX+ZpCVDHkFnUsIdQ0e3+ZKFIPAsBwyw6cGmkkTY1COvaBkAWLlIZ8gidMAYca6HIvtKGVj7dgYBcUGST74j21K/cEAQjw/sY2X0Iszzl+sgo0d0AMD4kfaI+im0VVXmYqIWvnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Me6ZcTGr; arc=none smtp.client-ip=193.252.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id dM0duYZ4uMzjqdM0euFkjV; Sun, 20 Jul 2025 06:50:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1752987053;
	bh=IaHGPBToEuHYujpU2aUAxomrlknUBKKmqIUvLYtaIC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Me6ZcTGrXMxKM+oWlsS839+BYTTXA9sISQc0X86SOSu8VPC1dIlCLU6at/is7P8Ga
	 djxE19FI0WrmUO3DLMUZDis2cGWS1vng8wg/JllIX9oG3gGQaUhT7AEzibtxAx/LHD
	 qUlYuVzrW4sHtPA6jLrHkFFdOFLyN0rUznukzgi3fdGRQzv7SQ/QndbAKLhwFV7NYh
	 M12bLHa2n8Li+l8QUiLGS9WMi2YzA28J6xNj7OWXYWonMoQxXz/eJTPKmEeYC4wgud
	 hpjnJ4tF8UDITCWUV4/r8nBipO8O0seQcpwMtz1cVEeFheWkV/ImBd7SxSuiHe4gs4
	 v/YVj7LHAl0qQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sun, 20 Jul 2025 06:50:53 +0200
X-ME-IP: 124.33.176.97
Message-ID: <9ce81806-3434-492f-b255-fad592be8904@wanadoo.fr>
Date: Sun, 20 Jul 2025 13:50:46 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: tscan1: CAN_TSCAN1 can depend on PC104
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "Andre B. Oliveira" <anbadeol@gmail.com>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20250720000213.2934416-1-rdunlap@infradead.org>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250720000213.2934416-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/07/2025 at 09:02, Randy Dunlap wrote:
> Add a dependency on PC104 to limit (restrict) this driver kconfig
> prompt to kernel configs that have PC104 set.
> 
> Fixes: 2d3359f8b9e6 ("can: tscan1: add driver for TS-CAN1 boards")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andre B. Oliveira <anbadeol@gmail.com>
> Cc: linux-can@vger.kernel.org
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> ---
>  drivers/net/can/sja1000/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20250718.orig/drivers/net/can/sja1000/Kconfig
> +++ linux-next-20250718/drivers/net/can/sja1000/Kconfig
> @@ -105,7 +105,7 @@ config CAN_SJA1000_PLATFORM
>  
>  config CAN_TSCAN1
>  	tristate "TS-CAN1 PC104 boards"
> -	depends on ISA
> +	depends on ISA && PC104

A bit unrelated but ISA depends on X86_32 so I would suggest to add a
COMPILE_TEST so that people can still do test builds on x86_64.

  depends on (ISA && PC104) || COMPILE_TEST


Yours sincerely,
Vincent Mailhol


