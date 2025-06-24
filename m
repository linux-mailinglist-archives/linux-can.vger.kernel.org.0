Return-Path: <linux-can+bounces-3890-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4C3AE72BA
	for <lists+linux-can@lfdr.de>; Wed, 25 Jun 2025 00:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302B6189A304
	for <lists+linux-can@lfdr.de>; Tue, 24 Jun 2025 23:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646CB25B694;
	Tue, 24 Jun 2025 22:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Iyp+cE6e"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-67.smtpout.orange.fr [193.252.22.67])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C8D2185B1;
	Tue, 24 Jun 2025 22:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750805982; cv=none; b=p2+44NDSJAHxYS+Ge66SMx7kWCkPj+CidOSeH1ixYYqqreC7N6ACkwXFZRdYkEpVFLPFqKqQ4ebb6GKS9t9bRV1XNjQBLvDveXsMEoJbqvGvLo2y8pjZdDc3hG0+9ykG23qtts0x3vDTAwWR1iV57j8snpiep7QBxaAFx5YhmXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750805982; c=relaxed/simple;
	bh=ehjSA+j5meOBE6rcPz6+oVi8w6HmWh1qJQR+e5ec/LI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T28ER0f3IOhe/OoiQQPGBtgjaxdgmiR5Ajn9m858oaZyjHPuN3bHyDIcEwmapUVDDA6PqEL2LyOhN/P9JfgWqhOyWYH14F9G/+2bEa2psam2p4ZHNxZzZft57BVqO/KiKaHom+mKdogd/YuJwL6ZNXo6SIa3W/a3MHBmSQnghmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Iyp+cE6e; arc=none smtp.client-ip=193.252.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id UCbtuQV63TFAkUCbvuE8B0; Wed, 25 Jun 2025 00:59:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1750805971;
	bh=XqLSgtZzHrFyqkW7/SpOafUJm6QcnmR6bfGTGlobI2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Iyp+cE6eTV0zH2cAKlOoVAUyZ/luJOn8iGT8sM977QEu/NBKpfC6f2vBUrlu7rhKQ
	 EgmmFLcnH9p8uoIfwlIZKvTQdxlfULaVa3hxCJO8y6IxlYBHQvbxvf20YtigrL7NbK
	 sOuBb+09bc9FznhqOXXCvS3bus9UptGoLO6c5lYiyqtLKSrlMY079rd8YbzCcFGdNd
	 1foFL3RayUX7FGvfBuP4iXBbmZunTxFvePs/udvYFCEsCSLle+cVseKx720JH0lwgZ
	 g2JColAAOHgbZvOH9sAtbeGpEsBv2Nxyp65ugDCi6nVtS02Pcp2HO0RKesWLTLyrsZ
	 dMOj+M/LCiMJg==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 25 Jun 2025 00:59:31 +0200
X-ME-IP: 124.33.176.97
Message-ID: <c96a5d2c-0ee1-4e3e-a95d-d38a8f668feb@wanadoo.fr>
Date: Wed, 25 Jun 2025 07:59:24 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: can: ucan: Use usb_endpoint_type() rather than duplicating its
 implementation
To: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Chen Ni <nichen@iscas.ac.cn>, Marc Kleine-Budde <mkl@pengutronix.de>,
 linux-can@vger.kernel.org
References: <48e217a7-b90e-4af3-b535-812c449dd3ba@web.de>
 <bf5442d1-34e0-495f-8a56-4e47f53ca4ad@wanadoo.fr>
 <a7a00125-b393-4283-a7dc-6c80ced8e7e6@web.de>
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
In-Reply-To: <a7a00125-b393-4283-a7dc-6c80ced8e7e6@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/06/2025 at 03:28, Markus Elfring wrote:
>> Looking at the helpers in linux/usb/ch9.h,
> 
> Please take another look at known source code mappings.
> 
> Passing code replacements by APIs (for SmPL)?
> https://lore.kernel.org/cocci/481faa1d-7171-4657-8dc0-c37b153e6eaa@web.de/
> https://sympa.inria.fr/sympa/arc/cocci/2025-06/msg00044.html
> 
> 
>> it seems that Coccinelle missed many simplifications.
> 
> Would such software transformations become better supported anyhow?

Maybe?

I am not involved in the development of Coccinelle and thus, I don't have an
answer. Nor do I have the time to read and understand the Coccinelle source code
to which you pointed me to.

My stance is that such static analyzers should never be trusted 100%. The output
is more an indicator. And in this present case, a quick review made it very
clear that Coccinelle saw one simplification but missed two other ones.


Yours sincerely,
Vincent Mailhol


