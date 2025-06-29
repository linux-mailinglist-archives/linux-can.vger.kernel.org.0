Return-Path: <linux-can+bounces-3923-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D33AECBC6
	for <lists+linux-can@lfdr.de>; Sun, 29 Jun 2025 10:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EF1C1753F2
	for <lists+linux-can@lfdr.de>; Sun, 29 Jun 2025 08:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD1F1FDE22;
	Sun, 29 Jun 2025 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Np8YppsQ"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-73.smtpout.orange.fr [193.252.22.73])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4338320B;
	Sun, 29 Jun 2025 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751186562; cv=none; b=gmfmu22gnXt+OC5huai1oZp93b8SnPfU7lvRp0c655bM84NUSKRWuP2yTbTZXizdNahm+HpT6hDgiFyXcAtqSzgdgl6F6ou89p8p+vTfVuOSH8FHH7GSazDX+zTLgK7VX9CaVAVRkCREg/HPilDiml4v4JtopJ+ROayinpPrD9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751186562; c=relaxed/simple;
	bh=1vR0hCj7PS77chk+ubL9x0VnkldCCkTPBOGJDFRwQsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pEzG6GvL0ruiJEXhlAow9LC1hgx22B+QU1+vu2fpc0MptIrDYRDLbq5c3jHMz6h9iTmWzHmcoYPAdG2CfAezPHqJ5gQZYyNG2ena6DgAx3DvK6ivP7yIg21zfJbtDjkv5JnIuEF6CyxBpHw14VAm0b3o/nKTMg9eEzpPwJmMtAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Np8YppsQ; arc=none smtp.client-ip=193.252.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id VnTiu8Wnbr9nZVnTjuiCjq; Sun, 29 Jun 2025 10:33:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1751186020;
	bh=Ic120Tw4SXqu1SW29ua5MOX2cM3lmV7dZjeyQ5spDak=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Np8YppsQTYN22Ynh59ZE6ov4rKNxBYq9+TFojWCFxTgeF0rODQpJyrm/palUs00Dp
	 F5611DEn2R+07oUZ97NnFkzxjsIVDXazUAsUMJg9q6JxCZKIwG5oIotEmNT+OZW8G7
	 qn+8yyYxlrPjlb08cCr3fFQ/k06lOwOd8dj40NtMqTsc1Zo++USfFMgk1VfKzNPzmL
	 alWvROTp749Hdk38JYz11ziGEQZCGMKsXLoHG+K4pgel40QG9RGEOZk0mh/QdVRsHN
	 G+nkOETaKGWz7S4siZkTDh0qF1+OSghiYDrnYOJ18oceT10ndI4AmtoFkGLirNPxzx
	 L2s3eQgBXSxxw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sun, 29 Jun 2025 10:33:40 +0200
X-ME-IP: 124.33.176.97
Message-ID: <a545127e-ee1d-44a5-bf43-149f81bda6a5@wanadoo.fr>
Date: Sun, 29 Jun 2025 17:33:34 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3] can: ucan: Use two USB endpoint API functions rather than
 duplicating their implementations
To: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Chen Ni <nichen@iscas.ac.cn>, Marc Kleine-Budde <mkl@pengutronix.de>,
 linux-can@vger.kernel.org
References: <0a675827-33af-4ec4-97dc-2e4523e41194@web.de>
 <c44cf0e9-9510-4fe9-aa67-edeaa1be6253@wanadoo.fr>
 <1d773886-1657-4a90-87e1-aaaa169f5783@web.de>
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
In-Reply-To: <1d773886-1657-4a90-87e1-aaaa169f5783@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/06/2025 at 16:51, Markus Elfring wrote:
>> Please use the same email address:
> 
> You may omit the header specification “From:” (if you would find other presented
> information acceptable), don't you?

You are sending a patch which has some checkpatch warnings and you think it is
our duty to fix your mistakes? This is not how it works.

> What does hinder you to support additional email addresses better?

It is your behaviour and your unwillingness to follow the guidance from the
maintainers which hinders me. Use whatever e-mail address you want, but if you
fancy mixing different e-mail addresses, then just stop posting.

I do not want to waste any more time arguing with you.

Nacked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

(no need to reply to this thread, I will not read your post anymore).


Yours sincerely,
Vincent Mailhol


