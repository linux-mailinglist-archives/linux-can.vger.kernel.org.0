Return-Path: <linux-can+bounces-3356-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D5DA79770
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 23:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8CD17A51E7
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 21:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387BC12D1F1;
	Wed,  2 Apr 2025 21:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IAIjF3+l"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A2A1F3BBE
	for <linux-can@vger.kernel.org>; Wed,  2 Apr 2025 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743628581; cv=none; b=uKRbtqh+hNwYigXrcYpMBnkHoVjH1eFGbsTn+y7MvSSIJnvlryZRW+5YGxtEG52iRcUR9ZOlGsjxLeBgn005kHUkxLjv5N5yK/VYYEa1QUzKLy5Om4yV1VC+KzP0jWX2dSZxKr1ySYU7PZnDtUk+8kpxkqH/TldoFLP33vLdf0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743628581; c=relaxed/simple;
	bh=yMtg/5bd9WuFFPh1QUVVbVzPyQ8PxgEFM//QPDYEqaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pr7mA/i6JouH18jrydbzgi9uUlkYxL9Y7Mb4U6h6xGy0QWfLAqH4eVar1T9oIIxj+DhJ1OloZDUq4YWpqcDbU/RwTNqCklXzp3YRUYhPdyT3Qy0g2DH+JW13VLvPIeQet2sVjeub2pwSlyL5FA+ePkErPBxjq6FJKhXt9TDB8s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IAIjF3+l; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2bfcd2a70so30072366b.0
        for <linux-can@vger.kernel.org>; Wed, 02 Apr 2025 14:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743628577; x=1744233377; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6vOkaWbZeGW9ejcyKHqKRgGRaPzQmhuks1cZQp6R9ag=;
        b=IAIjF3+lne5/FZ5JiAfjeTH+OfEIxSVKSWIysjOCUsHYmO1GTSDq1072HXWgaRzyQC
         tvR8GBLrRNH6c690alTf3xxvA4GLwUgvaetjAitwCpfOCCkOQBk40D4juttLk3ryiSqC
         ImnE70rBYN62trGoKCAGa1Ln5VY/NTRTHPf1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743628577; x=1744233377;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vOkaWbZeGW9ejcyKHqKRgGRaPzQmhuks1cZQp6R9ag=;
        b=BQT1bpmQWFYppeIPHdvoSQZKKHoGZ5DHwgKXSZQnPl6SLd/1JlO9qc/KpXUIMTHni0
         DdDvW+6eyz1KKHAS1CSKgM9LiJCzDY3/k0Z8z9H2ACAmEwi0lE0BAa45ki0GRt/yAMnZ
         KxnTwP/zikNTxfxHWTocutePug/MmVyU1/WYtuIaNxi0gNqTjdMSMhOKIWm7qTrRGlbv
         PbV8Yac2qao0Qk/V8EJaef+Sj3lW3YYGucJwj+H6/u2OH4a/9bMtQIMoLGfHxDh5PWee
         /2ytMurxPCJHJNy6kMlEEXa2+DnNHcOcy0NagOqIVGDwOILimKMoksOpHJ7W+rJD/vx2
         0YMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+WtKFd/S4IWt/tARQS+3DZ0vQKCltOQhPYUwEsCyE2Bt2ld79McWnGbhENfk+48qDnSOBvMdEePw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp3MzvjubZu0SEQvpVC4W3uVgVSXOBCq0rdBt6TUok/uSxEt89
	Q/vE0r404rUphiP7B+r4+FGwA4SrZ/v9Xk1IDVeEprVh4Hp+l/WIz+RuALCDKmRRSVvRntq81t6
	fPbUcsQ==
X-Gm-Gg: ASbGncu3a2EmZA8RWHItZAHV23jFANY3ApySUeFCIKXqabDM20wjgDqsw7R8TcufsMi
	BSLyCS7IQa/b1WTq+S4IbA64G/5wqW19kd0BDB582IKXrTBxhR6CNSPBhTDw3Z64GsXG9r+TGsU
	bYOKQchazyBwuOUAiAH94XTvf5ZqQPI3euIhICIoovBJxGxTwnVj/XG91w6a8EKsB7lxUMaehpC
	OX/E7fVlAcZ9RTsxjJlQeDXjc4I6ZgV5viFKiFy+tIDacFjphJCqo6jVUm6SfEWKpNNEbfJXGCE
	seJk37qb8oWKXmNd2MQnTDJRfVWRogmL4dPXHb6foqCICB5KHP7CHbeHgcaZjm0gQEWrByNaCk0
	5uZJyEW0ip+aknDZZw9qRpKws88FIpg==
X-Google-Smtp-Source: AGHT+IGcpP5AgKlHBYfiqlr0ntk+1+B6aXIHwnLzuDY6BUk7OZW0hjDn+iaeNYEZn3h8V8gVj6FbmA==
X-Received: by 2002:a17:906:794b:b0:ac7:1ba8:d2ce with SMTP id a640c23a62f3a-ac7bc134b23mr22241866b.32.1743628577298;
        Wed, 02 Apr 2025 14:16:17 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71966df75sm961982766b.124.2025.04.02.14.16.16
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 14:16:16 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5e1a38c1aso339755a12.2
        for <linux-can@vger.kernel.org>; Wed, 02 Apr 2025 14:16:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWH2WwtOZQSiG82mVKqhuMA/1CS3uJOBNBCzeTm1FFwnf2+tAqzt8fgbmCd3BMirngrduaffgLH/V0=@vger.kernel.org
X-Received: by 2002:a17:907:9409:b0:ac7:970b:8ee5 with SMTP id
 a640c23a62f3a-ac7bc126208mr19593966b.27.1743628091735; Wed, 02 Apr 2025
 14:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z-sDc-0qyfPZz9lv@mini-arch> <39515c76-310d-41af-a8b4-a814841449e3@samba.org>
 <407c1a05-24a7-430b-958c-0ca78c467c07@samba.org> <ed2038b1-0331-43d6-ac15-fd7e004ab27e@samba.org>
 <Z+wH1oYOr1dlKeyN@gmail.com> <Z-wKI1rQGSgrsjbl@mini-arch> <0f0f9cfd-77be-4988-8043-0d1bd0d157e7@samba.org>
 <Z-xi7TH83upf-E3q@mini-arch> <4b7ac4e9-6856-4e54-a2ba-15465e9622ac@samba.org>
 <20250402132906.0ceb8985@pumpkin> <Z-1Hgv4ImjWOW8X2@mini-arch> <20250402214638.0b5eed55@pumpkin>
In-Reply-To: <20250402214638.0b5eed55@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Apr 2025 14:07:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7p9bKgZt1E1BWE-NjwSRDBQs=Coviiz0ZTQy9OhHvPg@mail.gmail.com>
X-Gm-Features: AQ5f1JpKVAIlc4pALP5yKNCr8F3ijIqVBIOCCdqoIfNZomenel-ajZbKWJ5EdvE
Message-ID: <CAHk-=wi7p9bKgZt1E1BWE-NjwSRDBQs=Coviiz0ZTQy9OhHvPg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] net/io_uring: pass a kernel pointer via optlen_t
 to proto[_ops].getsockopt()
To: David Laight <david.laight.linux@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Stefan Metzmacher <metze@samba.org>, 
	Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Karsten Keil <isdn@linux-pingi.de>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Neal Cardwell <ncardwell@google.com>, Joerg Reuter <jreuter@yaina.de>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Alexandra Winter <wintera@linux.ibm.com>, 
	Thorsten Winkler <twinkler@linux.ibm.com>, James Chapman <jchapman@katalix.com>, 
	Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Remi Denis-Courmont <courmisch@gmail.com>, Allison Henderson <allison.henderson@oracle.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Jon Maloy <jmaloy@redhat.com>, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Martin Schiller <ms@dev.tdt.de>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
	dccp@vger.kernel.org, linux-wpan@vger.kernel.org, linux-s390@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-afs@lists.infradead.org, tipc-discussion@lists.sourceforge.net, 
	virtualization@lists.linux.dev, linux-x25@vger.kernel.org, 
	bpf@vger.kernel.org, isdn4linux@listserv.isdn4linux.de, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> The problem is that the generic code has to deal with all the 'wild stuff'.
> It is also common to do non-sequential accesses - so iov_iter doesn't match
> at all.
> There also isn't a requirement for scatter-gather.

Note that the generic code has special cases for the simple stuff,
which is all that the sockopt code would need.

Now, that's _particularly_ true for the "single user address range"
thing, where there's a special ITER_UBUF thing.

We don't actually have a "single kernel range" version of that, but
ITER_KVEC is simple to use, and the sockopt code could say "I only
ever look at the first buffer".

It's ok to just not handle all the cases, and you don't *have* to use
the generic "copy_from_iter()" routines if you don't want to.

In fact, I would expect that something like sockopt generally wouldn't
want to use the normal iter copying routines, since those are
basically all geared towards "copy and update the iter".

           Linus

