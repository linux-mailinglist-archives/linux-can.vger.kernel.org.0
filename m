Return-Path: <linux-can+bounces-1685-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBFA99E023
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 10:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446FC282679
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 08:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B05E1714C4;
	Tue, 15 Oct 2024 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vdladWKj"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C25E1AC420
	for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 08:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979293; cv=none; b=F2jEK+NfhkEkuQglAd+QFp4nFlKMKnkqNHAauttS7GGzQVvueiCrPzyl1kueoIa1+09UQn6pCCTrQh+94D6J/2/FPa0AGfBC4ES1DAzyiv0mN2h3O7MrlpVOg5O1eZhMdD85xIx/i438kCVVTAo+QLbOeSIyO/IWl/B1mHF0I/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979293; c=relaxed/simple;
	bh=zj3VWhc1JXRNGK9CsDmZf0eapyKovX4dwjoqx2Q9Dio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0WwuS4BjXK6sEieiq+aQPAtI3Z8WUsHNZv42v7kUg3XLOqY/2AUFpvkxpmuLRqHc6Yg6T3JF2zGMRWplraqILnnA4X4vdf8Rch90VQKIi7Yk640Co4Ab1xdau2khVEeaRZ7Sr0FXjD2+b3sBXS2ALu7c+MLdH4tnmWo+neips0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vdladWKj; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb518014b9so12481461fa.3
        for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 01:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979289; x=1729584089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zj3VWhc1JXRNGK9CsDmZf0eapyKovX4dwjoqx2Q9Dio=;
        b=vdladWKjT8WI2KeXleLj+/RcHhaLevl3oykRwHEj/ZVgkBv+hL95RJrvL0saG80l/8
         hvx+1Bb1fYt8letMQFveFcCn/7Bv4jMkKa0GTSDnD3WgpUDQmfKAbHlR90919YTxYlWp
         /MKxgZxRQSW5cvW6EI7vce1MPENxpdKmJ6vR1xTOZ56Myl5y/gBhADKnF2ML2nSNJBuo
         0CKgDhB/60XRjW7udytqDzU1zPwXbgv1lbIUxq2RuRGLH7WPD8QszDkoRbRkvyjXEJKE
         TyOi2XajDVnvWzSjxTBBTQUyU6PTe4QPzhkBn9L++TPSKc9bEbq5VQX4T7pRQg6sYw9v
         cyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979289; x=1729584089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zj3VWhc1JXRNGK9CsDmZf0eapyKovX4dwjoqx2Q9Dio=;
        b=C9g8KubVgRv2adKakxe55iuzT26H+XeubRcVTBIv4vmbKK1/WwL+7kT65veLBCPa64
         4HzAvQQS4ikiOT5m58Yur75F9LoJ5a8iXeMionz34GZ3Ta4jRSyyIX5J8SOivpBW9Xln
         GiV6blPNEOebIAq25/1saeZoWvwaQQaDiKpdd2f5nZ8vTWud2AjUztGNcaL8F8pLZUWo
         TAbbGJZ+Uv0qlWuAFnK3GlLhEkAu3z/OTcEQ3NJuapErSpe+sBBenUQQx4XlBErsycfS
         o6QOBFdhl4zNKZxqBz+VyFpaZs2/1sSKFNbh48wBRJgYVknoDBM9DRXe0S7aNR5QjNkU
         PRVg==
X-Forwarded-Encrypted: i=1; AJvYcCVfV6TtOJjtOM5l0NfgLZHZo6eq/f857str8KmY0FC76+2aPfvyHuc56fHBCEHpridzXHKnCbYVgdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBpdF//cU8fRS1oNYtVLO+NFb4DbYj1ce4j6PQg3Rh4JfF4ZhN
	FAAOtZ5IymN8kiuPV2eWMYU5GXW17tGV9C3vZibyCdPy5pLdPBg06I7q27S3e0kARzix1gNil27
	I46eGjO529wDxM0mOyXKKIKGYzErBtLtgjR9Z
X-Google-Smtp-Source: AGHT+IHxfKaPProiszu4hPKA2JsWyWKW8QC7WkdMfm3qCN+vO+7OHhDa8OoE6YIicZSOeQRLIab3tjlWn0zyThhZ2QU=
X-Received: by 2002:a05:651c:2120:b0:2fb:5d8a:4cd3 with SMTP id
 38308e7fff4ca-2fb5d8a4f7cmr6486501fa.0.1728979289048; Tue, 15 Oct 2024
 01:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153808.51894-1-ignat@cloudflare.com> <20241014153808.51894-2-ignat@cloudflare.com>
In-Reply-To: <20241014153808.51894-2-ignat@cloudflare.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:01:17 +0200
Message-ID: <CANn89iJ0i+k_wHn-aoafY1V+mJ8TAS1DzQKnu1KkjusAWLNuyg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/9] af_packet: avoid erroring out after
 sock_init_data() in packet_create()
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Alexander Aring <alex.aring@gmail.com>, 
	Stefan Schmidt <stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-wpan@vger.kernel.org, kernel-team@cloudflare.com, kuniyu@amazon.com, 
	alibuda@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 5:38=E2=80=AFPM Ignat Korchagin <ignat@cloudflare.c=
om> wrote:
>
> After sock_init_data() the allocated sk object is attached to the provide=
d
> sock object. On error, packet_create() frees the sk object leaving the
> dangling pointer in the sock object on return. Some other code may try
> to use this pointer and cause use-after-free.
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

