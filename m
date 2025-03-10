Return-Path: <linux-can+bounces-3037-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E80A590BF
	for <lists+linux-can@lfdr.de>; Mon, 10 Mar 2025 11:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 220E516C225
	for <lists+linux-can@lfdr.de>; Mon, 10 Mar 2025 10:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85992227E97;
	Mon, 10 Mar 2025 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="p4C2vohc"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-13.smtpout.orange.fr [193.252.22.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C081C227E95;
	Mon, 10 Mar 2025 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600531; cv=none; b=hdPvAwHo7K8YgeoaEs5JHXAwCFDkOV4X9yRyp0pxY52xNORcxmBdfZ6wDDm0Fe8jjEPqOYo54Is8IPzTRtaxeRNYNdDsTv5BQYqMCy9Y8ceIg2rtN48CszCvrWAhnaJYFzjG4mHaJrjhcmO14awAZfmfsB1Z7w74RmwK10T1TPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600531; c=relaxed/simple;
	bh=i4pE8u/XHrdA9344C8oXv2hE4eWk4M9/sOKpCz/S6Zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxlNqrzG9vVbdxiAZcrEZ2Ors3Jjk+WkS45UnaqkhTXOx8czzy7S/YFWjnk5b3YDdL+NDrhsFDOplVhxObyOUhbH1B8XOzV1VzeOLYIdQZ0W98JNjat4rhUplnls75kyoN3o2u3JVbYzNlww4Dnz6ugwBEw7hnhSj+iYhPxkKT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=p4C2vohc; arc=none smtp.client-ip=193.252.22.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ed1-f48.google.com ([209.85.208.48])
	by smtp.orange.fr with ESMTPSA
	id rZqvtxu0c9A4qrZqyt6QFM; Mon, 10 Mar 2025 10:55:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741600521;
	bh=i4pE8u/XHrdA9344C8oXv2hE4eWk4M9/sOKpCz/S6Zw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=p4C2vohc4A/hB4g6q8ih0tjK70nuNUDoIDp63RclMQTHSsr8VeLnJrmB2CN4u5ZrF
	 oUSt/OFEQJtCS6smIn3yUuPEDMNBb+dRBfTICsfFJ1AkRdBR2ez4mwAwMB8S2jpj+P
	 bv9bNmn7wBRSw+5/FB1WGgnc656404e1raJ7ptmyt8bgoW4PeH30Mh+ZiLj3Exy5P6
	 OSm579R9qMcAS99dwUj6JPNXqu28aHp6cMKfomWVjmmQINh9i45BnhPWn/IqUVrHsm
	 ZXWGMdVAY0f1l5CDfeB128x4tMAKgJbpgEbIz+v6NiM65vyF0kJ/gyLuQI2ktZFqxL
	 +IPgDQikG5VaQ==
X-ME-Helo: mail-ed1-f48.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 10 Mar 2025 10:55:21 +0100
X-ME-IP: 209.85.208.48
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso6670428a12.3;
        Mon, 10 Mar 2025 02:55:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXFSGJpFPXW2FXtjIMXbWHvGJMACfvA+Jgl9Hsu6hV2vf1IYO082KigJTMx+nNkXPgqGYT4T1m9OLo=@vger.kernel.org, AJvYcCXpvFr20DXYOUc42MY19iJ1gv6J4xUwDivqEPcJ48ThBx4ELRy07Ge7kbXkg8yuIDNRlvFmye6e1lfxeZkJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxEEOn4ANeaMyYgODo0zimg1R8E82Q4uYjbiHE/pFCDoaNH4eGV
	wodmB/VipLNVCfD83VunVCMm7DkWsoUyU92sMK+5nUp+5+nCgspdBWwC6iqfMIkzlf0+m4pAsB+
	ocVPebpJalpONhT5zofVB2uPeZb8=
X-Google-Smtp-Source: AGHT+IEdknV3g/6ie0NKekq54C7zANHwaPGViOXbrDTQU5rEkV2SSNDbYe+UNO+aPLf1QuDc95KJ9DudIiPaI3QBwQc=
X-Received: by 2002:a17:907:720a:b0:ac1:e881:89aa with SMTP id
 a640c23a62f3a-ac2525b9c95mr1504962666b.5.1741600517640; Mon, 10 Mar 2025
 02:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67cd717d.050a0220.e1a89.0006.GAE@google.com> <c9047828-708a-42d8-97f6-fffb7d806679@hartkopp.net>
 <CAMZ6RqKyMreMfNDmYU=tLyaEcReopmGx2VkBWPB12LLzd5o7Pg@mail.gmail.com> <f8e7f845-253b-47b7-9e09-97a580ce0e5c@hartkopp.net>
In-Reply-To: <f8e7f845-253b-47b7-9e09-97a580ce0e5c@hartkopp.net>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Mon, 10 Mar 2025 18:55:06 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqKga=f=Xd33GF1zPwmiearrz3mg+ZiryVbJD_RE5MGjKA@mail.gmail.com>
X-Gm-Features: AQ5f1JrZXeNMKQBc3ToVK21lghv3_OQv8DM-VpAfJoFaXW060wcyVIotaMf8eOg
Message-ID: <CAMZ6RqKga=f=Xd33GF1zPwmiearrz3mg+ZiryVbJD_RE5MGjKA@mail.gmail.com>
Subject: Re: [syzbot] [can?] KCSAN: data-race in can_send / can_send (5)
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: mkl@pengutronix.de, 
	syzbot <syzbot+78ce4489b812515d5e4d@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon. 10 Mar 2025 at 18:46, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 10.03.25 10:29, Vincent Mailhol wrote:
> > On Mon. 10 Mar 2025 at 03:59, Oliver Hartkopp <socketcan@hartkopp.net> wrote:

(...)

> >> Isn't there some lock-less per-cpu safe statistic handling within netdev
> >> we might pick for our use-case?
> >
> > I see two solutions. Either we use lock_sock(skb->sk) and
> > release_sock(skb->sk) or we can change the types of
> > can_pkg_stats->tx_frames and can_pkg_stats->tx_frames_delta from long
> > to atomic_long_t.
> >
> > The atomic_long_t is the closest solution to a lock-less. But my
> > preference goes to the lock_sock() which looks more natural in this
> > context. And look_sock() is just a spinlock which under the hood is
> > also an atomic, so no big penalty either.
>
> When we get skbs from the netdevice (and not from user space), we do not
> have a valid sk value. It is set to zero.
>
> See:
> https://elixir.bootlin.com/linux/v6.13.6/source/net/can/raw.c#L203
>
> And those skbs can also be forwarded by can-gw using can_send().
>
> Therefore there is no lock_sock() without a valid sk ;-)
>
> When 'atomic_long_t' would also fix this simple statistics handling, we
> should use that.

I see, Thanks for the explanation. Then atomic_long_t seems the best
(and easiest).

