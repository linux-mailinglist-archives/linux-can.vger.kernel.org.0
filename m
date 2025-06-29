Return-Path: <linux-can+bounces-3921-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3277AECB8E
	for <lists+linux-can@lfdr.de>; Sun, 29 Jun 2025 09:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FE31745A4
	for <lists+linux-can@lfdr.de>; Sun, 29 Jun 2025 07:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9CC1D9663;
	Sun, 29 Jun 2025 07:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="NbJ0zh/g"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-71.smtpout.orange.fr [193.252.22.71])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7649F4C80;
	Sun, 29 Jun 2025 07:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751181602; cv=none; b=jIGKgZvP62A9/A4LjiDGjdQwp1NZKNT2MpZo2DzzrxPY+0ZSV5iB5xE3jFoWuZpSuq+pYmmc/n0s3hIvI1duQzREjR0oX/J1XPT0RFUVQZ6btrjZCGIQmMePpjKsBvoVcsl9C6Kjcg+3WVlHGvgeN6VOSM8fa1WPpdMihDwtF0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751181602; c=relaxed/simple;
	bh=Wo44CvxUK/DfahvRn0+WY8Xf1xwyBQwlPsvZdyxyQ8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UyQQrjMwvNDev3/l2JFoiCYPRAcLqIxBS9ZwFEpXVohsMCDmPHh4dv/qd9gt085BgPPdyZcWGvJPRF03Ms0F6x6Bc5lyHyuJa5ir1axi/RI7JrRg/ywP4Fp8GydK0kD7qi5Cs0uaE95OB4BE5nhGxNixBiTZ2ScFXi3UpfNZ5Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=NbJ0zh/g; arc=none smtp.client-ip=193.252.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id VmKEuak3ewD4EVmKGug5zC; Sun, 29 Jun 2025 09:19:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1751181589;
	bh=rUJ7oCkTqQPMxpbg/HTKmR5FrDTbJ5iEWLtJVaOPJnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=NbJ0zh/gT6n772n7ole3Bod4YQGiifFCw9PWUi4AQUboLcf8D1P0YE8ThW6u3JzyD
	 O0uV23Jgy7/VOLNEKq2VfQ0Tn0mXCBI7uVZpxWoSh+VEknJv05hSeF8EDziXYr8JBT
	 IwB63S0kkdjx2Rbl1K2Dyar9YwyLVb7oef6SQu7quiq5G8ZY686WbIwPrMUFlviQoC
	 jNanhSyb9N1ovyZ2JZX4cMyO6zluVKffit7BkTT1qOXjYlLA6AbZ/IiDLLbxEPuuSG
	 ZAL7vQYngRpni/9qCICBkgnjNEIHXAvomyji3tgfVHS9w9Lv6nD0lU7CFWgqVH64DZ
	 Lpbj0tXzyN5pA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sun, 29 Jun 2025 09:19:49 +0200
X-ME-IP: 124.33.176.97
Message-ID: <c44cf0e9-9510-4fe9-aa67-edeaa1be6253@wanadoo.fr>
Date: Sun, 29 Jun 2025 16:19:42 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] can: ucan: Use two USB endpoint API functions rather
 than duplicating their implementations
To: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Chen Ni <nichen@iscas.ac.cn>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <0a675827-33af-4ec4-97dc-2e4523e41194@web.de>
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
In-Reply-To: <0a675827-33af-4ec4-97dc-2e4523e41194@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/06/2025 at 16:19, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 28 Jun 2025 08:56:51 +0200

Your patch doesn't pass the ./script/checkpath.pl script :(

  WARNING: From:/Signed-off-by: email address mismatch: 'From: Markus Elfring
<elfring@users.sourceforge.net>' != 'Signed-off-by: Markus Elfring
<Markus.Elfring@web.de>'

  total: 0 errors, 1 warnings, 0 checks, 21 lines checked

Please use the same email address:

  - To send the patch

  - For the patch author

  - For the Signed-off-by tag

> * Reuse existing functionality from usb_endpoint_is_bulk_in()
>   and usb_endpoint_is_bulk_out() instead of keeping duplicate source code.
> 
> * Omit two comment lines which became redundant with this refactoring.
> 
> The source code was transformed by using the Coccinelle software.
> 
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Signed-off-by: Markus Elfring <Markus.Elfring@web.de>

Yours sincerely,
Vincent Mailhol

