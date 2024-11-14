Return-Path: <linux-can+bounces-2061-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40FC9C8DDB
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 16:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7824F286AB9
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 15:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECF91487CD;
	Thu, 14 Nov 2024 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="sU68WJzs"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167A72C859;
	Thu, 14 Nov 2024 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731597877; cv=none; b=lgDAzMu1c8yxIMpi/U8VM4AuXAB2WuzVV9UCc8QaDM1mDn1cn1UMgXA43ijfUzo8w7Ik55KsjhnwlzyNIVsKz8n+aFG52Mb5cRXFOCt7B0mkdajnDdByHCUWPpUzs4RUS2muKHhX6KwpaPM6VmoMbbmKDsy6+edP9I7MR/YuJd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731597877; c=relaxed/simple;
	bh=xsVf3vew9SpRW1h1Z2z1A+QH4M4mxu4f69LMnQRUV98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpW4LanhBsaiv4xsxrUxK0OdrzPpE1WUM3esFtuV8+HjNA8Go/MDIgIv1CpXzngM1QlQNxZSEUFrp3YoM1Ha6AZVQRzT/4xK9ZFkJUg0CrLLEsYJwIQvcpdRXhlydz4HaYP918uaTwNqa8GNGZEusgrjGG7uw6oCudyLnhvOoTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=sU68WJzs; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id BbhitqbCk9tmtBbhrtq9SO; Thu, 14 Nov 2024 16:24:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731597873;
	bh=izzFa5suPr8w2SBDN7iZD4T89oyWBt6p8wvOJcttrRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=sU68WJzs4DKbkHpVLb/IM1jhnO6MA7K6B5Vac7upD4dChBDroo3OOBl5pllxPz+ie
	 +POA9pB3zED1p4gocSpHVjKAjsK0WkciLFh38CJY3JM6f09eFdic9s5mBlV9Cgbral
	 o83a/L9Hj8rw1pVPZDmCwxT/ym58qgKui6/ad65bDQ+wyt6ExEwXeM/Mh2Fe9yfJgx
	 6wJKGsqQz/cIWR2rjnlKYoCwv4i9LTtfqkUIcIut8jPNYFE1c6FFK+5/F+EIx2cjpI
	 oWFjQchODcDdhBWXt9JZKqSCZCgBGpNGC0tXxxoYpRXRmUssRk0zWX75xnyh8Cp5yO
	 MWXT401gTY1ZA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 14 Nov 2024 16:24:33 +0100
X-ME-IP: 124.33.176.97
Message-ID: <7d4b176b-6b44-450b-ab2d-847e5199d1b9@wanadoo.fr>
Date: Fri, 15 Nov 2024 00:24:17 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] can: can327: fix snprintf() limit in
 can327_handle_prompt()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Max Staudt <max@enpas.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <c896ba5d-7147-4978-9e25-86cfd88ff9dc@stanley.mountain>
 <6db4d783-6db2-4b86-887c-3c95d6763774@wanadoo.fr>
 <4ff913b9-93b3-4636-b0f6-6e874f813d2f@stanley.mountain>
 <9d6837c1-6fd1-4cc6-8315-c1ede8f20add@wanadoo.fr>
 <20241114-olive-petrel-of-culture-5ae519-mkl@pengutronix.de>
 <7841268c-c8dc-4db9-b2dd-c2c5fc366022@wanadoo.fr>
 <0c4ebaf0-a6c5-4852-939b-e7ac135f6f32@stanley.mountain>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
In-Reply-To: <0c4ebaf0-a6c5-4852-939b-e7ac135f6f32@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/11/2024 at 00:08, Dan Carpenter wrote:
> I'm happy to re-write the commit message.  Changing snprintf to sprintf() makes
> me so much less happy...

OK. Let me amend my previous message. I kind of understood from the past
exchanges that Max will take the ownership of this patch and credit you
a with a Reported-by: tag.

If you keep the ownership of the patch, then that's a different story :)

I do not want to make you sad and I am fine with your preferred approach.


Yours sincerely,
Vincent Mailhol


