Return-Path: <linux-can+bounces-5903-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD24DCD6E34
	for <lists+linux-can@lfdr.de>; Mon, 22 Dec 2025 19:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F419E30245C5
	for <lists+linux-can@lfdr.de>; Mon, 22 Dec 2025 18:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFEF2F7ACA;
	Mon, 22 Dec 2025 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQGEt8v2"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8A82DCF57
	for <linux-can@vger.kernel.org>; Mon, 22 Dec 2025 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766427736; cv=none; b=r4MscG6eas+VFbt7XW1QApqNQ6v/wYdJgxgVfuEd/VC6rSypXle1E9GtCDRXZaPLZKj7l9YrLeDyLEsKh3hAE9RWEnAHSo7xGAUwG++Sc0mqaC/EZor1lIbQRMBZICuSvt0hBPGJKQxAlUm+OR5RiJAufPgxfWHbFPdFc3fyKRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766427736; c=relaxed/simple;
	bh=PspIumBe+iTtYPSn0/F9OZy3n3LfxhvhqBjwakNUly8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWTLzy7WYlj0cQHksMj5Qvd6CbGZwT8xrdX+0KbGuxtNxf3mexibfnMovnOvcx/6znEHrQZYKfCSb8LVLNIJMWmC1T2eRbB0o5nuukmkCuN3g59dGXM8JL5glvv6eyAfn1+gtOXLw7fYnQJrQYDv47kxxO8JGnIhLqS3DxqsCkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQGEt8v2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47bdbc90dcaso28387885e9.1
        for <linux-can@vger.kernel.org>; Mon, 22 Dec 2025 10:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766427733; x=1767032533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oR2rep0bhoWET14XJZVLvIr5MH7A34XNIPdTSdrxt3E=;
        b=KQGEt8v2xMySAHqnS1OcalKe3qeS8bY56p/w708ZkRbK631XiFjWI7zcd59VKbwmsf
         Jk279P6tCp/qO8rAOrrokAeqwYidXk5onQWzE1edFqnWMdqyH81AAy+uo93wsBmj9JaP
         DYq4mz4vdKt/7uHdodw6DI1TTr+XciLkW83btjBWM1vbm3WuPQNozxbo3qxkl/xWE+Lq
         6+iShKri31noAsqcnmlqI8yKeiggJF+QGh0DgXO98dFG6ZhjcZsRJxkEzHOZHd6KZcPi
         u/ERo6vnYiWoz0v96brPForLP82T/cP6lPffF7onUFVRCct9+R/XUH8ZIg1bd95iawmA
         bOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766427733; x=1767032533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oR2rep0bhoWET14XJZVLvIr5MH7A34XNIPdTSdrxt3E=;
        b=YtbBDiqtjYqDtUkRaLZrXPBKmtZP/ziMTB6SPVNOrNYKCjr09G2L0aDf4K4i4m86SM
         +s0c2mynzHHHbI9PlxCC6vAJSD8NQmhdofamHwY/zhiUe7t4828ezF+3RBtp6/Y+ntpk
         03m3p9QNTglUvqCcJ6u3V9NjCDpnZe/v6l4kppUTOnqU0H/znIL553SbX7BZtszf5r1Q
         rB7Lp3p/8xuKOVm39tyfVHSCEgxsJryKlhwC6gRajcTGwrIDT8KDyUWcxw9layQjN+js
         WemJMyz7hkJ+rVzmg0PAV6QxXhXdeGD0+9hN+dv+V+FIXLf+1qQQiJY0I9Iygbu7yuwh
         M4XA==
X-Forwarded-Encrypted: i=1; AJvYcCXOFLppuVvWZ1F2nVYYJXHS/JZMiD5qRhgEBiYhvX8hy78qS2ElwEMt2BRtvBXbN8VSnVA9WOSogoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB6ODLvanaeDeAMEFENtr/hbz9tTQmR1658UD3FIqc0P32u7Zw
	v5XyC8NIe7AajynzBysvtv5ERFS2S1uM9M6M72qOcIL9MnH2HDp4s36p
X-Gm-Gg: AY/fxX4+4RzcH/ZHC5BQPHyDhoQeLgmnhWmN6Bp0Kb7dkdHAXS/0ZQ3q5ap7/ZIR0rf
	Asgf6lRObeN3o12crLh/hBxtnEqbU5m3KLapUB+fjoVIojlsKNiRU1soqNqhZCj0aIlIWbxEcI8
	U6WrXcz376GfIEzwiuai9gce4nqFHrxRmMixKKhpPSvVcWmNShNfcI8DZ2d7S6k2y6fiPkMUN5l
	ZvXVSkoJq5gNZGT5WERZyScbLkZdohzLngjA9ufwOvu6bHmQaPCtjWX35h3DYTEMvRlsymEga8o
	x0gDBz4LQNkXGiddi/z8yxRugqGqlpsfrOELn0DyBtdAF2MyUJ0boz4UqSkdzxA5/3JS1atKMKw
	CW7pRyQSsEo4hXL0Cfncz1KTr9UEpGrQo7uoqwoUUJaOShIE/W7rQNS97/gvsF6ID7tFgBWan+z
	lA0lpRRpbj1/HVjInFqQxtsqpD5KEXeKMk+eat1R2nCwz2Gz3D/sbm6v12pmxb1A==
X-Google-Smtp-Source: AGHT+IEVWzbNFvXXJ94RvZjNEhXIYaVOr65NRyrf0Wy3hxmQf6dr1+8Au8WvTRtTjC4EBhedJMWEmg==
X-Received: by 2002:a05:600c:628c:b0:47a:7fbf:d5c8 with SMTP id 5b1f17b1804b1-47d1958296bmr109337795e9.26.1766427733286;
        Mon, 22 Dec 2025 10:22:13 -0800 (PST)
Received: from pumpkin (host-2-103-239-165.as13285.net. [2.103.239.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43264613923sm6651697f8f.26.2025.12.22.10.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 10:22:12 -0800 (PST)
Date: Mon, 22 Dec 2025 18:22:11 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Ondrej Ille <ondrej.ille@gmail.com>, Andrea Daoud
 <andreadaoud6@gmail.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Christophe
 JAILLET <christophe.jaillet@wanadoo.fr>, netdev@vger.kernel.org
Subject: Re: ctucanfd: possible coding error in
 ctucan_set_secondary_sample_point causing SSP not enabled
Message-ID: <20251222182211.26893b94@pumpkin>
In-Reply-To: <20251222-kickass-oyster-of-sorcery-c39bb7-mkl@pengutronix.de>
References: <CAOprWotBRv_cvD3GCSe7N2tiLooZBoDisSwbu+VBAmt_2izvwQ@mail.gmail.com>
	<CAA7ZjpY-q6pynoDpo6OwW80zd7rq3dfFjQ1RMGzJR4pKSu7Zzg@mail.gmail.com>
	<20251222-kickass-oyster-of-sorcery-c39bb7-mkl@pengutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Dec 2025 17:20:49 +0100
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 22.12.2025 16:51:07, Ondrej Ille wrote:
> > yes, your thinking is correct, there is a bug there.
> >
> > This was pointed to by another user right in the CTU CAN FD repository
> > where the Linux driver also lives:
> > https://github.com/Blebowski/CTU-CAN-FD/pull/2
> >
> > It is as you say, it should be:
> >
> > -- ssp_cfg |= FIELD_PREP(REG_TRV_DELAY_SSP_SRC, 0x1);
> > ++ ssp_cfg |= FIELD_PREP(REG_TRV_DELAY_SSP_SRC, 0x0);  
> 
> This statement has no effect, as 'ssp_cfg |= 0x0' is still 'ssp_cfg'.

The compiler will optimise it away - so it is the same as a comment.

> IMHO it's better to add a comment that says, why you don't set
> REG_TRV_DELAY_SSP_SRC. Another option is to add create a define that
> replaces 0x1 and 0x0 for REG_TRV_DELAY_SSP_SRC with a speaking name.

Looking at the header, the 'field' is two bits wide.
So what you really want the code to look like is:
	ssp_cfg |= REG_TRV_DELAY_SSP_SRC(n);
There is nothing to stop working - it just needs the right defines.
Sort of FIELD_PREP(GENMASK(25, 24), n) - but you can do a lot better than that.
The inverse is also possible:
	val = GET_VAL(REG_TRV_DELAY_SSP_SRC, reg_val);
#define GET_VAL(x, reg) ((reg & x(-1))/x(1))

    David

> 
> regards,
> Marc
> 


