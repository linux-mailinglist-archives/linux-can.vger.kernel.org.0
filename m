Return-Path: <linux-can+bounces-7799-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I+6BD/eFKGoBFwMAu9opvQ
	(envelope-from <linux-can+bounces-7799-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 23:30:31 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B079F664415
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 23:30:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b="TcmC/V6Q";
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7799-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7799-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9F2730300C5
	for <lists+linux-can@lfdr.de>; Tue,  9 Jun 2026 21:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E10141168E;
	Tue,  9 Jun 2026 21:30:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6543E120D
	for <linux-can@vger.kernel.org>; Tue,  9 Jun 2026 21:30:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040628; cv=pass; b=Ru6RC4J6sL3er+sAxdT5g1SrdkWq8wdhK90Nru+ku1I2H/FuO9FrShpOQ2PEkHtWY9+qUOOcTTfElYDnGXVoqzgJaNtxYihW2v3OsdIKCKDJgreokAS/ypl3p+bNlIau4FrrZyT/qQRpO7lQ+cQyqOFYVLPBgep2G88Byq4taq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040628; c=relaxed/simple;
	bh=TbynbP/rbCQk2ywH5TiPVu9krPSvulMPQby7aN5rr0s=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjsbOI4UReXhp2L01jjl8dB2jXxUw3GDj3sF93Q6Iu4n6Q5wj2ELNj5Z/6A5DUjw1BKaTihezcLoIOVZta2TwZSa5Z/MaDxR82RqVsRUOJZV8TIz9dMu5m72YjnWHhWmrhDGKxigPGstbXzaCHR1S/AYXciECsGH3ejzksnwQ0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=TcmC/V6Q; arc=pass smtp.client-ip=209.85.218.50
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bec450b950dso877578166b.2
        for <linux-can@vger.kernel.org>; Tue, 09 Jun 2026 14:30:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781040625; cv=none;
        d=google.com; s=arc-20240605;
        b=LmFl6zoBgoBlRInoszMRrahC5jDrMt0QxRfskEhnV/U+AgohWXb1CdQRRAzIxDcniW
         KcDzX05X3CbI6xLtTE8q5RldSOoUnxp5qfKHohTmjpnszzoNi0HtenLXLHdB6w4ZUIFL
         QDoTJmIP3mzlHJnK7r8X0Df6q2JKncVDSRqGYdDBx3xgPPHiSbWfWjKwt312Ow58RNBU
         zuPZbz7LOGc1wha63y3OXku6ggjFJgAedSxMDKL22eL72qxQqEwWHklJ8zAqi1q3ZxtD
         jdDHaHf39lh0G3JaQK9S3CRDJ15s5XNjEaS1UFddnh3UMw+IvFrrEzzO2doZcYZ09mFQ
         QXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=OyaoLWvSBSKiTIcOe7IFeaXY8jjEo9UJ9whgcmi/C6I=;
        fh=jY3iVAz79m+o+kuRQZcTA6YilwP3GFP7Z3jF7RmQOf4=;
        b=eBsOqGhmy8cPYioVWpoU4p/SAeSrKkAM51DwVp1YjUqKNAp7hbMtozOsRt3kKv2i9p
         +6kgOBoyW4tJyOXBhn5JlWrX/AK0GseX7CEpKeL77MkT1aTYl+tJXg/vYHc7OIgMl6Kl
         yll18azrh1EXzBg3U64DY1QCkW2xzWPVc0lFsQAh3mBcp1x7wNWvwBw3N/Hvr5EVEsmg
         7/7apXumvCTOdMd1DshyM+ry6Lc2mh5ATlByzuvw0rFQzWs1HPL3vCEKGpaPhNE7gARX
         H3+THDCt/32Ck1pM+pZI5jvQC15+5BDVTADg77aflhixIxLoYoSvfswZK5ATjYYQ1KmR
         LkNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781040625; x=1781645425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OyaoLWvSBSKiTIcOe7IFeaXY8jjEo9UJ9whgcmi/C6I=;
        b=TcmC/V6QXQfxwZKSWjtKlkvjOwoGt3xSPNg+O3KPbq/fsdAH7hoPIx2dJMRtxmQTDN
         c/FuN1pAa/+rFBM/8t6MyolmQjEbFoaajsLcwXG1asaHuZ0TYbMK9sODkclAppLdvDa8
         XEqEr8UlaPYpVpXIivFBHpa92NURMdaJ+DmTgLEoFu0oHxzM+5JLV35D+p9VDIjXHUKN
         Uvs5gA/R3tFy5Wc6kL+WSt84rmFgd588ff00SnkV/5TwmN+369ZaQj/8CpoOOQ7c8iCX
         /ZKNIoloMz0ViWo2W+9uOwnZ2zRmN7jrXekx5SWZaz+Z37Prrq/QMjiQ2YTGWz5v5osl
         CoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781040625; x=1781645425;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyaoLWvSBSKiTIcOe7IFeaXY8jjEo9UJ9whgcmi/C6I=;
        b=qyLhGjkEQMTjcV3SPxnkZaKmjBpmBeifufit44kRbR3p6aJZW80nRJoTE4E9YXCuXH
         arTQN9CrJUcViuSjudx2WHtTRhX8nKV4G6bUo4dXMR/db2xdkV8OpzGA+ZTbcbSTE5eR
         KmHlFq/lL+fWCUVQVWKC+C5NThL28E5UDWrZoXLhBP4lRc/UeI+8/eiEVRy+G7KWM92V
         Vq7wfouy6RqpFhgZhBF2A3t017nF0L72n/JzD9Lhssu5MEHaf9qFLdftfZ/97EhTLNP6
         q/PFMMrzqcGKcKYAmFD2i0dnM1WjnVj+E4peZpXQubu0psk2cjwBpS7aoBq9QAkHFLT+
         S71A==
X-Forwarded-Encrypted: i=1; AFNElJ/VbBbPetBhd03qtYHXMOdGUW/M2GYaVe2b9ozYsOU9yJsxelz7tpJ0oYyu7DiWppMuEQPh79Ym0Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDlMkZ5Z97d1oZC+KLYsfJZ/16UFPYVLKoAfAumkxFsukH2B1+
	ayzC8OD5XxryRBwaG9aHTYNm7KLU0Yafbh9WN4A4FuD6nqtX79CNMn/TYa8zHnhuUgXHZAgzNHz
	pT3uipwhGgbygqda9/FoEpWbva4qN+4YE6WO0sbP/Ig==
X-Gm-Gg: Acq92OFl+isuaPeeu+M8iG3Tj0J7XzLvNds82fqFQ3aWieySLREEY6wxYp9cXSw6Jlt
	hvR0bWXbThff7Olos9md6ywc2aiGqrvRdw7cfgyM+HdRH1XqLPIK+5MeJULUKi1/xIdG/RU57NW
	4HG4jClnqxqbBmDa0txt6Hy/K9jxiM/CcBJ4tQpuG3iz/mPJtXKZH8UEcUbWhVFHga0IMEZE6C+
	debTPs70w3XCKCjjdUbLW5lOYYgWDR+Qcimn6hmYWmycIJgMZo7qudN5g325GU9lZ4v1mxvn2bh
	sSR3JGhPJP0HYyTxgPJ0FDyW2KGYSLgMuyaUVnQlbU45LLE=
X-Received: by 2002:a17:907:8693:b0:bea:3e9b:83b5 with SMTP id
 a640c23a62f3a-bf370e63a84mr999800966b.22.1781040625083; Tue, 09 Jun 2026
 14:30:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Jun 2026 16:30:23 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Jun 2026 16:30:23 -0500
From: Angelo Dureghello <adureghello@baylibre.com>
References: <40aefc39-bd98-460d-8aa7-5dd79f562e0d@app.fastmail.com>
 <fdd6fc14-f607-4186-8db4-25de973ac322@kernel.org> <CALSJ-wCrNDv3N2Kdo0uoXsKGtp0GthJRBeYTNQA1gGE2akUWFg@mail.gmail.com>
 <9391b782-7727-47fa-ac37-05cd50821d35@app.fastmail.com> <CALSJ-wBRmUpjz-_ehZ0U0Gu+fPqRUeAn47E0_pwpXQa0tCNzVA@mail.gmail.com>
 <CALSJ-wCuZs9cBJsuOOYMEYM6xOXZbdOm_pr=70d3HRYYSYJ0KA@mail.gmail.com>
 <CALSJ-wDm8NoB8mF3KSx49XMSWz1vjwFhSmgJZWq8pN2pCf12mw@mail.gmail.com>
 <CALSJ-wDY_8SMAvKT0L6wMbH1=w5pZNmV=xyeX1REb=BMRZWj-g@mail.gmail.com>
 <2b532d56-dce4-4f6d-84e0-2fd87d5494f8@kernel.org> <20260601144332.GC4918@lst.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260601144332.GC4918@lst.de>
Date: Tue, 9 Jun 2026 16:30:23 -0500
X-Gm-Features: AVVi8CezOGOq-MNrhv5y2nA_4hBEGDCtfXzAaSWT86Uo7sqynIRfYGOJbVIBc1M
Message-ID: <CALSJ-wAaOsizvHGiCdL_mSKS-LQGJKgbnUeBAnE8H+h-7xOGhg@mail.gmail.com>
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX() functions
To: Christoph Hellwig <hch@lst.de>
Cc: Greg Ungerer <gerg@kernel.org>, Angelo Dureghello <adureghello@baylibre.com>, 
	Arnd Bergmann <arnd@kernel.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-spi@vger.kernel.org, 
	Vladimir Oltean <olteanv@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7799-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:gerg@kernel.org,m:adureghello@baylibre.com,m:arnd@kernel.org,m:linux-m68k@lists.linux-m68k.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-can@vger.kernel.org,m:linux-spi@vger.kernel.org,m:olteanv@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,lists.linux-m68k.org,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[adureghello@baylibre.com,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adureghello@baylibre.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid,baylibre.com:dkim,baylibre.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B079F664415

Hi,

On Mon, Jun 01, 2026 at 04:43:32PM +0200, Christoph Hellwig wrote:
> On Sun, May 31, 2026 at 11:42:26PM +1000, Greg Ungerer wrote:
> > I don't think that is right. The way the underlying data cache is setup for
> > MMU ColdFire (via the ACR/CACR registers) means that individual pages cannot
> > be marked as non-cached. So coherent memory allocations are not possible -
> > at least the way things are today.
> >
> > It would be possible to set aside a chunk of RAM at kernel startup time
> > to use as a pool for coherent allocations (since it could be marked as
> > non-cached via the ACR/CACR registers), but there is no code to support doing
> > that today.
>
> With CONFIG_DMA_GLOBAL_POOL there is some generic code dealing with
> most of this.  But if this driver worked on coldfire in the past,
> it must have been fine with non-coherent memory and could use the
> non-coherent allocator.
>

Ok, thanks, so the driver is working fine with non coherent memory but may
be just for a case. I will try to setup a better SD test. And will send
another patch to have dma enabled with non coherent allocator.

Regards,
angelo

