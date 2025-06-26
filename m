Return-Path: <linux-can+bounces-3906-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49475AEA1D8
	for <lists+linux-can@lfdr.de>; Thu, 26 Jun 2025 17:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172106A6DAC
	for <lists+linux-can@lfdr.de>; Thu, 26 Jun 2025 14:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51A12EBBBC;
	Thu, 26 Jun 2025 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="CnB+jpkD"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-67.smtpout.orange.fr [193.252.22.67])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC532E6133;
	Thu, 26 Jun 2025 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949456; cv=none; b=mEnZX9KiZsZEs3pcfZEzOGfctfip2elcHbf043zq0VXnAtqM6A4gAFlQBiudyyUC0fyCyGYy1WTNAQdBrumrHsDiKBRetLw3FKP4dBAT1kp8cPp54de7hFUDMbIsEtO8HsS/u/MM4xLDALVX2GOUeAJE5aiBh6Imqbo2B5Eoi9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949456; c=relaxed/simple;
	bh=0MP0tnHu6fQzXUoVEVy0aE8NoUMK5QMnnmNk1hZfbuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uXqioOZXN2D+AFt2xaPkm4ef4sx7xVe257M+uO128Qxxcv7I0TnXi0KbfHiXGpWYD9unHSeAJfqpfNvXtND1AYFqRLRK01aXpYyTi8wvgy4H7KtHp3ngARKi0a14iJfB1vv++LbAAED0OGnhQ6UX+kqlIhlwkncnWT/sp+aOCwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=CnB+jpkD; arc=none smtp.client-ip=193.252.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id Unw1uePibyDfnUnw2uCBbf; Thu, 26 Jun 2025 16:50:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1750949446;
	bh=CK8v7DCERysOk/Rvq1+fguI+gY89l+aE5AQv4JbT6Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=CnB+jpkDINyf3UqSzYPPQJB+Qvb2iXDfs+CitNx9wZRVzbBWVk72ORRI4sfdsVmdx
	 Pkw9w2hYRmAFxspd8ZaxIn5N9EkZgc4qZMBsDFEvmkuDxvegoItYANif1yL+It/RwM
	 9tkQaxA3AxV6egyd2A5pUnssifsF/P/4dxwMlMij1jKpQ1/MMb/SrZdxwgdwv496LL
	 GAB7lreuVvY0kuVaBMq1QLmToBHCXa3lfaNwgPawj5Lf1vOOTD7AHaIvxFJ1I7YQld
	 tzU9ZnJQ2oO3wZJi0xTQHIHFWX6GQK4rw+8tt/SZpBJvWHz3tOeBjq4bNgYpo0OEuD
	 BezRNYqa16niQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 26 Jun 2025 16:50:46 +0200
X-ME-IP: 124.33.176.97
Message-ID: <4af1102c-a5b6-4d9b-af8d-2c5f721b845e@wanadoo.fr>
Date: Thu, 26 Jun 2025 23:50:40 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: ucan: Use two USB endpoint API functions rather
 than duplicating their implementations
To: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Chen Ni <nichen@iscas.ac.cn>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <48e217a7-b90e-4af3-b535-812c449dd3ba@web.de>
 <bf5442d1-34e0-495f-8a56-4e47f53ca4ad@wanadoo.fr>
 <a7a00125-b393-4283-a7dc-6c80ced8e7e6@web.de>
 <c96a5d2c-0ee1-4e3e-a95d-d38a8f668feb@wanadoo.fr>
 <0768a008-d4a9-41ec-bc47-1e7c63362296@web.de>
 <c04376f2-6ab7-4256-8bdc-aa6ff3ea88b4@wanadoo.fr>
 <7e6f8929-6665-45af-b01b-167a1aa80305@web.de>
 <CAMZ6Rq+PEZWzxNYDODq-Rz_Y8T_XEihyZKoY-MYo6bn5ATaGLQ@mail.gmail.com>
 <1e64bcef-33f1-4295-b91f-d4598b32b866@web.de>
 <57815326-740d-4053-8b85-c5e57d7cec90@wanadoo.fr>
 <e70a929f-a5c5-487e-9231-61b5423115db@web.de>
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
In-Reply-To: <e70a929f-a5c5-487e-9231-61b5423115db@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Markus,

Thanks for the v2.

On 26/06/2025 at 23:46, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 26 Jun 2025 16:34:26 +0200
> 
> * Reuse existing functionality from usb_endpoint_is_bulk_in()
>   and usb_endpoint_is_bulk_out() instead of keeping duplicate source code.
> 
> * Omit two comment lines which became redundant with this refactoring.
> 
> The source code was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


Yours sincerely,
Vincent Mailhol


