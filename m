Return-Path: <linux-can+bounces-2605-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D78BA0A9F6
	for <lists+linux-can@lfdr.de>; Sun, 12 Jan 2025 15:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06FA33A0654
	for <lists+linux-can@lfdr.de>; Sun, 12 Jan 2025 14:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ACA1B4F29;
	Sun, 12 Jan 2025 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="nDH8t1mk"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-16.smtpout.orange.fr [193.252.22.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE54829CA;
	Sun, 12 Jan 2025 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736691504; cv=none; b=UECvKiO3fxVE+4r5SVIsYCHSkPz2SfERUUwVgWp8dFsUGCiEUNdqfXVsPOYVEu11nXBJVwp/9bOJUwgxV7tb4qJzfX8NV0Mhj17IZNbh479L7Dn6UbXkFrYwT2Z+BWPvmiUq1T2sfIRYi2svzJoUyFDAlIuQkmd7lbYWfFp4a0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736691504; c=relaxed/simple;
	bh=/E8/ad59bWfpp48DZweADzGfTUv9gFIC+TwRHeLkO+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BEaUnjWfmfUtsVNS+JqqzFDNsk4t/j0o3kKBDRrmccfmRImkW+FSWWTKKy9eTJkt/JYsg5VFFqV/vY5aG1C0D3oARD7RLNtfcdUEDn8FHltpgGTgJmC0lL28uWAixKe7yBvC/iC+0kPwUoDOkGIEfPS18NRbwBGw3epo353vYdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=nDH8t1mk; arc=none smtp.client-ip=193.252.22.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id WymrtZpRHQS6pWyn3terfc; Sun, 12 Jan 2025 15:18:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1736691492;
	bh=gpIjNeNmhfIKcQGaETaoxOqM269CanGnN50QoA6S7gA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=nDH8t1mkA4jVNVvcOqfSxzhH2w+H+kUHkuzaKOYpZxpANn7ZRl3xC7qd2vFpCtmB9
	 Otrby7MblRkZ0CK+ex60znP51soESLaTm1DfLUMvquTY6PZ2SZ20vbseVPcdRjuc2v
	 6exUEe+ps6gfhA5l4vLf4AiTLp3VDqMKs1u3K+oBfOTc4uiW9vNgAiqw2i53Ar9SWq
	 3OYmaS75BmHsJqii/N/gLdtKPvTHROdSQQrFk72RUxcCORfkPsOKnQ5l/+WsIB8mXq
	 N+CwBwQ/KXX5ZPHfpv/mBTaddFGzbQDv5FCqayzt3o7osERJj2+aoIyF4pCjRxqKP/
	 GOkaCJt/Vd8+Q==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sun, 12 Jan 2025 15:18:12 +0100
X-ME-IP: 124.33.176.97
Message-ID: <5119977b-acdc-4005-a1a7-bbc6e82412c9@wanadoo.fr>
Date: Sun, 12 Jan 2025 23:17:56 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/5] can: c_can: One fix + simplify few things
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Tong Zhang <ztong0001@gmail.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, stable@vger.kernel.org
References: <20250112-syscon-phandle-args-can-v1-0-314d9549906f@linaro.org>
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
In-Reply-To: <20250112-syscon-phandle-args-can-v1-0-314d9549906f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks for the clean-up!

On 12/01/2025 at 21:41, Krzysztof Kozlowski wrote:
> One fix on which rest of the patches are based on (context changes).
> Not tested on hardware.
> 
> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (5):
>       can: c_can: Fix unbalanced runtime PM disable in error path
>       can: c_can: Drop useless final probe failure message
>       can: c_can: Simplify handling syscon error path
>       can: c_can: Use of_property_present() to test existence of DT property
>       can: c_can: Use syscon_regmap_lookup_by_phandle_args
> 
>  drivers/net/can/c_can/c_can_platform.c | 56 +++++++++++-----------------------
>  1 file changed, 18 insertions(+), 38 deletions(-)

For the series:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


Yours sincerely,
Vincent Mailhol


