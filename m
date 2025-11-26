Return-Path: <linux-can+bounces-5671-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C5635C88D34
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 10:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D3DE3478EF
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 09:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5242B30171E;
	Wed, 26 Nov 2025 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sOpxJnGv"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B753112DC
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147851; cv=none; b=QyH8oOVQWE5zaktG+QhnG5+85OYn58wqF9Gn75idBVobOiR5W/GWXvw+pHdsCfzEIamAaeTBFHmhqwX7feaifUCwLnPRyzK4et+1wOwPIO5+Suz50dlT/vcgy+1nKDtFe3BGM6rY0LkqwFSz1p3/4YOyBTZ4bFdBGTuMOfry9ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147851; c=relaxed/simple;
	bh=msA1Bmidu73lv6UgIPfMu/uKxgKN3WMlHd0YJZqFXso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DTWjn8+GfGrpXQcEQXesbfO+Pn03a8PlNBrNDBhZZJrjIUjUJQgphXQObVhgGaC5uMHBiHwXSyccQ9CciRf8aflAjXZo/dDJtp8GGVAW4IHMhAgjO/8DHCRQD/ncPJA82qgsubFV+cd9cUKhW2J8wA4gh9ReDLta7c4OiV6Bae4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sOpxJnGv; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ed75832448so87838741cf.2
        for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 01:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764147842; x=1764752642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyRh8xXL0L8kVbM1qWyCLwjKZ6UbKVPw2m1+P8OYNlQ=;
        b=sOpxJnGv3ACf/h6aEZtQTVsMLfcSr1mRWlVQTJ09a2bfIw55plRjSMIcfHnZiHVW6s
         b2PtvVfB3gtWUvCQMXd2b6E6Ed94wtJ4sIywer91pv+L+W0adMBP1MgYqu4gCSeNLEek
         KUO1XhdZnbh5/SA/tix+WvQ1HyofMlw2mFpGJBJIo02SPWyHT1AfQdbyJ8AT97LYVVW0
         yYYGH4DI+y6fq7LRGn4gLXubfIt3+BXmNGOXVoMC8vi03Rol9fzaMIaBViclYeOpT843
         qiuJXRQKuzqlZFcSbTheevlOH0bB7Ku5CyNWvKiJQcGe6MPLs2UR13/Uwt7DuaaH6906
         p5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764147842; x=1764752642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hyRh8xXL0L8kVbM1qWyCLwjKZ6UbKVPw2m1+P8OYNlQ=;
        b=vxouCZZ8BkEbUhhCGmdIsQCwAZb/6QX55rklBBJqS/ay46hxGfxuXTGGpbz1it3EQX
         JAdzQhYPRg3nQ5PntO9CvwEgmgbnwxDAVoZbhe/vJq794JWNtxrVAzW/oYTaNhJxZTTy
         Vy5XOzeuo2rq49u3vnr3l7OFhbvk+MrsgqMNEx7vVd0L6gGVm7pS3N5yAs68xD9gvPr8
         m/QIqsC6MwZ9evbDi16vHQNxhUX/a937mc2rmYAaS+dxOe04KWV8L3QL5daWOF9zDkYH
         7RrNowoOF6/phvHorXSwWhuer1h0H3Uq9lyqEIQfsrYyh/WrA6oWYz+sKNBMHa1/Oi4Z
         LrqA==
X-Forwarded-Encrypted: i=1; AJvYcCXtYoqxmd1lRLOrZHTWV/8SjYtg/22c4a5KWgXEGaQX7ExxSiZ21HggIJuMUP1sCXk655L3qZ+0Dno=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDmdP2wrPa5IuwbLf/wXUxudK/pwVcNIexyLlDjWrrzIBZiiyo
	r+jtRSYTlI0Ws/k1nqE3w2Aa+7XneyF8xJEOkiM6e1h0IXjyAUtdcydiAnrlulJPSaYENESlJcg
	1ZPBgkj560p6khqVSImRCA3WJz8l/W7Cu4D0uRi0D
X-Gm-Gg: ASbGncu1wcEeGOIikImZWYGzVYFQz8bAao2NNjaHJ3T0qzt7hvwcQgdZJs3kRVYLsrN
	oPD1r5xW9eMaAsDhpOZlTLCQTqcJYwO9ZkF5tinQrzV777wUr5ybMkctqBDQhRnt2AwMHjjVvTQ
	N/RNFBlVUK7+tKlMsh7Fe72L+vEyEQ4r2q7JboN+JH3a7/pFwtkAHib8ph/9TT2FnI7L+Dj95If
	Q76EHOXGKl4Q4HF122TM9LMP+2oeNzkWwlMOOaAFQ8iycIcUW3jJiVF91cOxrW7FioG/A==
X-Google-Smtp-Source: AGHT+IEPVELKVM1cwUwrfGMntJ3piYPimKdkJDSl5UF5isYNXZBNp4wQ/L7Ai4Aqn4fzrw9sl0QMSXAAIJOZ5vJ9tYw=
X-Received: by 2002:ac8:58d4:0:b0:4ee:1db1:a61b with SMTP id
 d75a77b69052e-4ee58b04acbmr253389301cf.75.1764147841940; Wed, 26 Nov 2025
 01:04:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126085718.50808-1-ssranevjti@gmail.com>
In-Reply-To: <20251126085718.50808-1-ssranevjti@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Nov 2025 01:03:50 -0800
X-Gm-Features: AWmQ_bmE9KDgoqH9fUKEjaUj9BjCwLFusadkTUuVGXRtTtcEL0ewy5b2wK6n-kg
Message-ID: <CANn89iKRYHaYS_wC0CzxsFD6pCHv126xKDbVgozBKvZyK-j7Yw@mail.gmail.com>
Subject: Re: [PATCH v3] net/sched: em_canid: fix uninit-value in em_canid_match
To: ssrane_b23@ee.vjti.ac.in
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Rostislav Lisovy <lisovy@gmail.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com, 
	khalid@kernel.org, syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 12:57=E2=80=AFAM <ssrane_b23@ee.vjti.ac.in> wrote:
>
> From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
>
> Use pskb_may_pull() to ensure a complete CAN frame is present in the
> linear data buffer before reading the CAN ID. A simple skb->len check
> is insufficient because it only verifies the total data length but does
> not guarantee the data is present in skb->data (it could be in
> fragments).
>
> pskb_may_pull() both validates the length and pulls fragmented data
> into the linear buffer if necessary, making it safe to directly
> access skb->data.
>
> Reported-by: syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D5d8269a1e099279152bc
> Fixes: f057bbb6f9ed ("net: em_canid: Ematch rule to match CAN frames acco=
rding to their identifiers")
> Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> ---
> v3: Use CAN_MTU to validate a complete CAN frame is present
> v2: Use pskb_may_pull() instead of skb->len check to properly
>     handle fragmented skbs
> ---
>  net/sched/em_canid.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/sched/em_canid.c b/net/sched/em_canid.c
> index 5337bc462755..2d27f91d8441 100644
> --- a/net/sched/em_canid.c
> +++ b/net/sched/em_canid.c
> @@ -99,6 +99,9 @@ static int em_canid_match(struct sk_buff *skb, struct t=
cf_ematch *m,
>         int i;
>         const struct can_filter *lp;
>
> +       if (!pskb_may_pull(skb, CAN_MTU))
> +               return 0;
> +
>         can_id =3D em_canid_get_id(skb);
>
>         if (can_id & CAN_EFF_FLAG) {

For your next netdev patches, please read
Documentation/process/maintainer-netdev.rst

Resending after review
~~~~~~~~~~~~~~~~~~~~~~

Allow at least 24 hours to pass between postings. This will ensure reviewer=
s
from all geographical locations have a chance to chime in. Do not wait
too long (weeks) between postings either as it will make it harder for revi=
ewers
to recall all the context.

Thank you.

