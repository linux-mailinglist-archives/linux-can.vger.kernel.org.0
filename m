Return-Path: <linux-can+bounces-7343-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHaAHFwD1WnOzQcAu9opvQ
	(envelope-from <linux-can+bounces-7343-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Apr 2026 15:15:08 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D4E3AEE73
	for <lists+linux-can@lfdr.de>; Tue, 07 Apr 2026 15:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 793193014953
	for <lists+linux-can@lfdr.de>; Tue,  7 Apr 2026 13:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5F03B6C12;
	Tue,  7 Apr 2026 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTdbOMJf"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6553B635F
	for <linux-can@vger.kernel.org>; Tue,  7 Apr 2026 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775567704; cv=none; b=Nh/upZQ7IUy+UD4gxHygczphSCFxdSuEaO70pXM3EV4ZNi+7+zQCBIvQ5TCqjRA1BmjkAAoKdPRINgeMvGkQtIKwLVrAtmeoRqBfmUWO/wUe/+ARn47cgkxy2xNFToA2O3SzqJdljEYg2WgJynD9dK5mQASddZ9tkANmJZONc9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775567704; c=relaxed/simple;
	bh=DF92KS7lR8TG5SktVvEPsLa9rP8Xq/XSF2frVXwEcDQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TGkLqUivUk38LA3reKRIu17ME3f/R7nuXKd+ooi0FcfhOapwDduFRZ6JOynUJBN91CuUTxpKpzIOn19xzyg5lMb0Gmza8+bitdtAJORPNAixu0iCymsh1sEAlCgTMAqgj4YkRHI7gjngxgEqOBnVVGiQNsaA86bDn0Hxzw6h8kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTdbOMJf; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d01232ff4so156874f8f.1
        for <linux-can@vger.kernel.org>; Tue, 07 Apr 2026 06:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775567702; x=1776172502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uJvui/baQIu/txwJ5Ha20q2FY1f9Fze38J+v8nYikoA=;
        b=MTdbOMJfQ535jCQ+aiD+tMAPmx/VsEXx+6Y0bcx0sIxiTol37cEMuxS6culODqZQca
         ishbncW9tdovM9HTjasVIE6hCKx17mnpVx6CBUttgtJJESn9EXe2Wf3ruwAmgq3dGn8E
         DUKLk89UtUZrcq8O9kgqKq51u7HnamzEgce9iIdh3NKsogWIEEVdpVw0oZL52uqdPsOh
         QJoEwGwXgK6Gjcg8gJ7OnfVV3i1yZNqtc/845lVodh0KqMhRNjYlOcsj2Ti70YYcgYxF
         vygk2WzLzi9ZmMi4bDgHRAh7NFwB60PCfIae4nuE78VYSMY+u8P9KPCNEChZi+6JYLDE
         VXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775567702; x=1776172502;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJvui/baQIu/txwJ5Ha20q2FY1f9Fze38J+v8nYikoA=;
        b=HpWV70SbYBIemjHy8AHBkKcB29Ur5ijsrO27oskoCmGFez8qn/PKmOhWw4HfYT7szL
         vHYGLT/PM530kg5XlTYcmV6c7B8b7RukBcMsvb2U8Zi+nE96eDyEY6azIoMZUrRTRfwN
         /zaVAvs1c1bhJ1aSzRpJyMxqAQ2g4YoWBCznJtzxmpbiihIJA94wIhPl4IU9eOrPQkKa
         2AwyzWfL5mwwwD0Pl22ix5nsb83vaWiV7XDjxI2ZtBk6VS7yzJe9gNyFWolTJNRaYxam
         OgLsPf+CpZ1y7Gch3wbaQeEehXriVyk2fUCD8u52+rqqyO7Mbt68TKnVwx5kqUeqUQDL
         /Ufg==
X-Forwarded-Encrypted: i=1; AJvYcCUad3LmLMKJR2PkKZOofqiO8Fs+j1TBNYygSOdtQ4xcktnLEGnUW5oPYR5A7a8b2ljgKzBfmkTepnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcNut5WhqccFsHJNoepNOkaqZU2psGxG+VsyQ8M7PeUZTcRU86
	AGiDd9a0WZGHZrL9wXBHlo11hrhhq0liN4eDBjwwzKQNzrcD5zxd3+aB
X-Gm-Gg: AeBDieuHW4tFriEpeR9v4CmCPQsP13EcdeCgfWbnlXPeE/OGLHydg8qwIJPQCeWfiBH
	klthlML5xFY3KgoG57dl4C2FGhIAnCa4s067GgvYQPPNhMHslDkXN3ubDECihJ3dM93scx15AQr
	06U8jXQV3Fn4ouilKmJXYX5TeG7AEBkzANSNmDJXnA7GpOX78qCzSnUIrSxlFpXpGlGPMgAOVAk
	pDNhALP9ym8iQSWGdNEbdOmpc94xgKdgzphMvwmmRSC3nzfNeUOMplFqbaUfgLhm180JAwN2Pre
	p1Zeoix+LZjUuHstgkjdB1SextQx9MAWzpS3Pns13NQjOEUaquacI32QDtInfYtB9ug8EbY2w41
	kYyW+TasnNncAOnPr5tfjpJVnVl4ts7e4Jenmf8cugkXE+j9eETG+WlkK4/VcV6CuYcrTD89z7c
	nMs0sU72QfZWhIMmewNyTB2xXlyYA6aiqYHFhiwXs1mP902VzxeyRgqvYjFnjdYbBwtg==
X-Received: by 2002:a05:6000:26c3:b0:43c:ff6f:d5c with SMTP id ffacd0b85a97d-43d29262a74mr12097140f8f.2.1775567701402;
        Tue, 07 Apr 2026 06:15:01 -0700 (PDT)
Received: from [128.93.82.131] (wifi-pro-82-131.paris.inria.fr. [128.93.82.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f1esm47942710f8f.2.2026.04.07.06.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 06:15:01 -0700 (PDT)
Message-ID: <0746a585-710c-4bf0-b54a-41573d56a2e5@gmail.com>
Date: Tue, 7 Apr 2026 15:15:00 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thomas Fourier <fourier.thomas@gmail.com>
Subject: Re: [PATCH net] can: sja1000: Fix pci_iounmap() buffer
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: stable@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260330154236.98665-2-fourier.thomas@gmail.com>
 <20260401-effective-piculet-of-will-704d4d-mkl@pengutronix.de>
Content-Language: en-US, fr
In-Reply-To: <20260401-effective-piculet-of-will-704d4d-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-7343-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fourierthomas@gmail.com,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B3D4E3AEE73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 01/04/2026 12:59, Marc Kleine-Budde wrote:
> The cleanup functions in this driver are a mess. kvaser_pci_del_chan()
> should only delete one channel, but it deletes all. It also unmaps the
> iomem, which belongs into kvaser_pci_remove_one().
I'm not quite sure because  kvaser_pci_init_one() allocs and registers all 
channels, so kvaser_pci_remove_one() should too?

> What about switching the driver to pcim_enable_device(),
> pcim_request_region(), pcim_iomap() functions instead?
I can write a second patch to do so, this would for sure solve the problem. 
Should I? I have no way to test it.

> When called from kvaser_pci_remove_one(), "dev" points to the master
> dev, which uses priv->reg_base without an offset, as it's board->channel
> is "0", right?
I think you are right, the normal path is fine, but not in the error paths for 
devices with channel other than 0.

Regards,
Thomas

> When called from the error path of kvaser_pci_add_chan(), things go
> wrong, and in the error path of kvaser_pci_init_one(), the pci mem is
> unmapped again.
>
> regards,
> Marc
>


