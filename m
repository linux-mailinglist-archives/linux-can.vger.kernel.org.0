Return-Path: <linux-can+bounces-4017-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E73D3B0BE0C
	for <lists+linux-can@lfdr.de>; Mon, 21 Jul 2025 09:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B4EC7AC828
	for <lists+linux-can@lfdr.de>; Mon, 21 Jul 2025 07:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0491F199947;
	Mon, 21 Jul 2025 07:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="rGZ4Ex8f"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-72.smtpout.orange.fr [193.252.22.72])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA28222590;
	Mon, 21 Jul 2025 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753084113; cv=none; b=aGD/LMNSU+3Zx0wcqjsAD7I2JMrYnReaz834vQj86+rEd8n0GaDhYZ6Sc0iIAQL+PYS/Be7s4IXI5kGRZtd63/FRRtah/up6d1Do5jbnkklsH7agNQboxQDcZqAqUcHHWfNB21JhWi1LNz7M9RlACVNXM34xBb9Au5GRVb5ZQqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753084113; c=relaxed/simple;
	bh=nDLgxabm1d7xOeJPLKicTvI/q87/XFoWr/jFEv4SLzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNBrQtJS+QX2ZyRvhslcayT0o3htYlZaiRZ+0d1ApyIzrUR5r3BlUsmk6GRw1FehNv5+Zw7U20Bj/yxKyDSuVq3b0rzOlJHRFcAZRcMc6mwwRgnSciZY7Wye903rdyyEoB75VudFfqjLVDSsIj/lYACVz6SZO3Q3B1bZBwhjN/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=rGZ4Ex8f; arc=none smtp.client-ip=193.252.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id dlFuuyWYqLTrpdlFvuXW2h; Mon, 21 Jul 2025 09:48:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753084104;
	bh=gJRVz/YEJYxqdLyzBaVoa58GpKVWf1l4S/w8WDWxRrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=rGZ4Ex8fUiy7IILm6R6Je7lCOpG2jm3/iBBWnBq0npkX0GUJlNlEvI6SEAVWa5Xvt
	 MvADXtgfypf1wX6WWfrJ5GqudiA6waPsDWuLfm4At9zoEyUqaudBSK6e7Si0YPVNr2
	 3iqPoi7fovIpv5/4EcE4QJVQPxpuBRX/mGNw+FMUV6d1IJ8BLzKi+1fUUkkq15HfbP
	 SLmBXJogUoDl76w3LMu8rRhZWnkoNp0oYZ8I23O820g5EGVxcHUnbZFkrft9jC8pay
	 hs3aO/fsMgFo8joV1Xuhdish8r/UTUu68V8FAH0u7uZGB+nmNM0d2bNZ4tpkkb0PWL
	 wDECYDekjweXA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 21 Jul 2025 09:48:24 +0200
X-ME-IP: 124.33.176.97
Message-ID: <c0cac011-cc07-42f8-bdac-620f3faeebf2@wanadoo.fr>
Date: Mon, 21 Jul 2025 16:48:13 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] docs: Fix kernel-doc indentation errors
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Ondrej Ille <ondrej.ille@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-i3c@lists.infradead.org,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20250720152401.70720-1-luis.hernandez093@gmail.com>
 <20250720152401.70720-2-luis.hernandez093@gmail.com>
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
In-Reply-To: <20250720152401.70720-2-luis.hernandez093@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/07/2025 at 00:24, Luis Felipe Hernandez wrote:
> Fix kernel-doc issues that reported Unexpected indentation errors
> durring documentation build (make htmldocs) in CAN, I3C and GPU drivers.
  ^^^^^^^
during

> Convert formatting to proper ReST list syntax to resolve warning.
> 
> Changes since v1:
> - Convert return value descriptions to proper ReST format
> - Fix code block introduction with :: syntax  
> - Add GPU driver fixes
> - Remove SCSI driver (already fixed)At

The change log does not need to appear in the patch main body.

Add a --- cutter after your signature and put the change log after that cutter.
This way, the change log will automatically be discarded when the patch is picked.

> Link: https://lore.kernel.org/all/20250703023511.82768-1-luis.hernandez093@gmail.com/
> 
> Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
> ---
>  drivers/gpu/drm/drm_gpuvm.c              | 16 ++++++++--------
>  drivers/i3c/device.c                     | 13 ++++++++-----
>  drivers/net/can/ctucanfd/ctucanfd_base.c | 12 +++++++-----

Can you do one patch per sub-domains and send them separately? The maintainers
of drivers/i3c/ are not the same as the maintainers of drivers/net/can/. And
there is no dependencies preventing you to split.


Yours sincerely,
Vincent Mailhol


