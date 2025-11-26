Return-Path: <linux-can+bounces-5669-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B18CC88C91
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 09:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C03D84E273D
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 08:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3819C31A810;
	Wed, 26 Nov 2025 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="dCF06ZMW"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5627B31A54E
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147439; cv=none; b=TNroFO7flGFMhmq+oPOFR+GAyiKmI1avW38jaP8yrTS+cLLpbUIxjNbau2GeL1R+b2AxXIllhVJiXdGQD+/LqksGsvhvICRYGwGlxqB9Q1CoancYB7av+sTOWMLWxD/KvUmafcDPpvtXjze0D6/t/5sEVaLdKCsB+21/f0b+Ey4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147439; c=relaxed/simple;
	bh=nT+9hkMMKO2a0c2dfjEfFHNaAZraFsUcksi/FyJvXog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWzz96NbEfmytx567TL8qPSTlJGlkvnxv71KLH1iV94onbMnHgLxnuu/xLkFNGLgHONLrPRgklFmzws1Kf1npIz6RQDc+vz6ESTlltTr+wz0YtZ2iRynBuESvbI4B7ah6zLXnXGe7mIBkwFMmTCm/zq5C4tpMe71riOSh9uibvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=dCF06ZMW; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78ab03c30ceso27170387b3.2
        for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 00:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1764147436; x=1764752236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OM6Ho99eQFd7mP86XuPFjtx25R80Ho6T6bFHAVogBI=;
        b=dCF06ZMW+uFpH/MXMZnG1J9O5gXd2I7u6cL2ZAm+qFO0L86jQSFxg5DNPXAMa2RNlk
         Ng/lOOuGLkTHvdDYTk0KiVJR8TeAo842XnKj/g3+0tB8XHBARydAP/B8VC3Qvm/BLOFj
         wbX/+uTUtWbEjOtDETcLPjWutf/0SIsABFWII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764147436; x=1764752236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4OM6Ho99eQFd7mP86XuPFjtx25R80Ho6T6bFHAVogBI=;
        b=HD7ZLYTkozqVY4wjNqjP0mBcy+OmeX+lohrFzNp/78qBUdleVJ+kqF/z55FzKc+V4a
         Q1cskfuAac9wVLiSzn8COtMmiUYR5RsyVkxuYyMImjJOht8SIKuQprMUwjh5IkmOeGFx
         BXUApTt2/XkHqE+nTt2H1X/b57IU/s7+0e0gqG+H4ApUFXl8eTxeXY5Z3CCzwCA975/5
         6pOAPRNOPkC9OXEEII5Tw5a5QEWG6tQ4JWN/oYUNw2sf/lLnEHumH1hLnaAExpe6N+V0
         K3/Fe3U7Cb0vxE4yDdFK/jOqpjMLQkS/qzJJ5E6gJfHLAtPy54J0HzAqlAYcCiYsm/1J
         FpHw==
X-Forwarded-Encrypted: i=1; AJvYcCXHjzwV7RceoIc8OQgZL1NYJi1NG1qC1pFdalPqyGaeaACBor2ATgSGWjZcn53amJ/MqJ6ASxDKZ84=@vger.kernel.org
X-Gm-Message-State: AOJu0YykLVtYzwmxYQTjKEjXZibGC3vee+UemxQWjzTISrZAwopgRqwK
	MhwE5Hn5WAXfr4RHbInaWo4zVs672l3SMk004gl05m8UdVvnpFVYpByRmxUA3XuHjOAhQ3lcUTv
	WYl6DmlkZS50E+TtHaS0avkfTtYpcn7Q9FrqByrsIuw==
X-Gm-Gg: ASbGnctylBCxijx3Bz2LY7c3ujKmzf2UA30xzJEHuFL9l6p1tYc7w2AZZ2kmLYLZQmC
	4r0MfYb5y3Zk/lu6bcS994KY8rB6zx2CHVqGonbYC2SKKq2lgaurh2sTqhMBbzWQNRLMw5+dgKl
	Fd6fWFjUaH4RuvWyG2JcDmRdF1HUqVukP4o9K6Dq3pCiWN4xMIZvQBbvB7PoGccSVGnr6vx3GDB
	3z0bkywGnOdrIGzKrvE8FWq8cCqn4qVBiWyKpu5FqTbI3ETnb0Ab+u5+PR83k0lRMLCWGPjnO7p
	NY5RejoNkxbICPKuOXwObKhgDA==
X-Google-Smtp-Source: AGHT+IHJIvCtQDQdlog8TUzs2kVVtyqB7q15hp22o49qFK1YOQ1sGDEwLFExhJCLMavAo58rcSOOrmdo7LPuV53mr+o=
X-Received: by 2002:a05:690c:e1e:b0:786:5789:57df with SMTP id
 00721157ae682-78a8b528a34mr142965887b3.45.1764147435965; Wed, 26 Nov 2025
 00:57:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126070641.39532-1-ssranevjti@gmail.com> <9c9e9356-55c2-4ec0-9a0e-742a374e0d04@hartkopp.net>
In-Reply-To: <9c9e9356-55c2-4ec0-9a0e-742a374e0d04@hartkopp.net>
From: SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>
Date: Wed, 26 Nov 2025 14:27:04 +0530
X-Gm-Features: AWmQ_blI3bICHE0wZGePxKvJM3ZGKSLwaqnMni4SAIeax_i_EG-2dclrwCiuaQ0
Message-ID: <CANNWa06P=u44r=Nq5Er+iuJW=aEpaAq0L7HKn9id+KLjy_pEtg@mail.gmail.com>
Subject: Re: [PATCH v2] net/sched: em_canid: fix uninit-value in em_canid_match
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Rostislav Lisovy <lisovy@gmail.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com, 
	khalid@kernel.org, syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Oliver,
That makes sense EM_CANID operates on a full struct can_frame, so
ensuring CAN_MTU bytes are available is the correct approach. I=E2=80=99ll
update the patch accordingly and send a v3.
Thanks for the clarification!
Shaurya

On Wed, Nov 26, 2025 at 1:33=E2=80=AFPM Oliver Hartkopp <socketcan@hartkopp=
.net> wrote:
>
> Hello Shaurya,
>
> many thanks that you picked up this KMSAN issue!
>
> On 26.11.25 08:06, ssrane_b23@ee.vjti.ac.in wrote:
> > From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> >
> > Use pskb_may_pull() to ensure the CAN ID is accessible in the linear
> > data buffer before reading it. A simple skb->len check is insufficient
> > because it only verifies the total data length but does not guarantee
> > the data is present in skb->data (it could be in fragments).
> >
> > pskb_may_pull() both validates the length and pulls fragmented data
> > into the linear buffer if necessary, making it safe to directly
> > access skb->data.
> >
> > Reported-by: syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D5d8269a1e099279152bc
> > Fixes: f057bbb6f9ed ("net: em_canid: Ematch rule to match CAN frames ac=
cording to their identifiers")
> > Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> > ---
> > v2: Use pskb_may_pull() instead of skb->len check to properly
> >      handle fragmented skbs (Eric Dumazet)
> > ---
> >   net/sched/em_canid.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/net/sched/em_canid.c b/net/sched/em_canid.c
> > index 5337bc462755..2214b548fab8 100644
> > --- a/net/sched/em_canid.c
> > +++ b/net/sched/em_canid.c
> > @@ -99,6 +99,9 @@ static int em_canid_match(struct sk_buff *skb, struct=
 tcf_ematch *m,
> >       int i;
> >       const struct can_filter *lp;
> >
> > +     if (!pskb_may_pull(skb, sizeof(canid_t)))
>
> The EM CANID handles struct CAN frames in skb->data.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/i=
nclude/uapi/linux/can.h#n221
>
> The smallest type of CAN frame that can be properly handled with EM
> CANID is a Classical CAN frame which has a length of 16 bytes.
>
> Therefore I would suggest
>
>         if (!pskb_may_pull(skb, CAN_MTU))
>
> instead of only checking for the first element in struct can_frame.
>
> Many thanks and best regards,
> Oliver
>
>
> > +             return 0;
> > +
> >       can_id =3D em_canid_get_id(skb);
> >
> >       if (can_id & CAN_EFF_FLAG) {
>

