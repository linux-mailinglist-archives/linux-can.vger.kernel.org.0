Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0974AEF761
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2019 09:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbfKEIjj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 5 Nov 2019 03:39:39 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40392 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730512AbfKEIjj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Nov 2019 03:39:39 -0500
Received: by mail-qk1-f194.google.com with SMTP id a18so2758565qkk.7
        for <linux-can@vger.kernel.org>; Tue, 05 Nov 2019 00:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PRYNbG5QNqFG128DjZPqd8sFESURUG3UtspoRmOBrrA=;
        b=LTH5MH7ZAzm0mUlaa9ZRsoQN6SuoAu77crA2KANEa+TsjOsmVOrZfqU8TmrAweKOtj
         Pp3rCJ0Zg210f0W7/MZSWOFFlUI6WaEaVxJku//rUB38V8QoX+KFoun5XZfRulSqOhYE
         9CGw3TId+2WjPbtcOFIOmpMtD6DaOHg3KsVDrMHWQ8vpDBqSwU6ncFEY96jKEPUcoA5d
         JSgauFt4wasEaP4niqeVx3gt7ZMEZ/3KMxGOYDE085QR1UwyFc1X+FzsH5Pr9p2AVN4R
         BcvyMF3Qcq32etyGx4E0APTzVCCD1bVnq4pEv0Loy2njx6i/omS5o0IAvpFiywrWqmyC
         IhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PRYNbG5QNqFG128DjZPqd8sFESURUG3UtspoRmOBrrA=;
        b=BNSNqb+dqW3+spcybJBj+CZrR2Z7C8eeSaA+sR93LsL0lwFmdxZB5G1M3AHW63HmeQ
         nKZLG3eLnMMH+QvBAxdlpc0cpZPlFMBGjLYP5iLSOZSAqbrmnRWhDYgokwpO7YC0tpex
         kQNHEzBq8xyoFrA8DFwgY8JfaYVlNOcOlTKmpceHRXvR5tadDFE8goZXXZ5eztGil8q+
         XWf1kpUdlHU3z5wm8tep9Ez2C9z1/ebGanLKfN6GgVdywlSdtm8woO/60u9SGILcixZt
         mmNqCrYtvZvMDUTBcnDpfJHBLMKroWFo0AJlg6jx2r7nlG4Jb12LTtZRbWyupOus0x37
         IGOw==
X-Gm-Message-State: APjAAAXTy+WOc17jQA35CbkyiGdaxQhaTymnU+pVHpzlkoIL/Tqnd/z0
        wkWCoHMFbV/kmEO8xqWxwOm2el1XXo/YZakJiUbBMw==
X-Google-Smtp-Source: APXvYqwpbDMvK36UP0DKRl7ceK05YYEpzXcS/e1r4u3yL1kFyGmZSy+oPtbsVNFRkImS/BYLJd4IeXJrI+fFRp6fw2s=
X-Received: by 2002:a37:6845:: with SMTP id d66mr11846617qkc.407.1572943177401;
 Tue, 05 Nov 2019 00:39:37 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009393ba059691c6a3@google.com> <0000000000009427b5059694e33c@google.com>
 <BN8PR12MB3266A0CC1496ED5D532EA6D5D37E0@BN8PR12MB3266.namprd12.prod.outlook.com>
 <969f940b-05ba-3fbf-79ba-95dc1cebc40d@pengutronix.de>
In-Reply-To: <969f940b-05ba-3fbf-79ba-95dc1cebc40d@pengutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 5 Nov 2019 09:39:26 +0100
Message-ID: <CACT4Y+Y+zudxSaNc4-b02QWu9hPXHrReCKsOLBpscMub5KN7+A@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in j1939_session_get_by_addr
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        syzbot <syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com>,
        "arvid.brodin@alten.se" <arvid.brodin@alten.se>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "robin@protonic.nl" <robin@protonic.nl>,
        "socketcan@hartkopp.net" <socketcan@hartkopp.net>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Nov 5, 2019 at 9:35 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 11/5/19 9:21 AM, Jose Abreu wrote:
> > From: syzbot <syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com>
> > Date: Nov/05/2019, 08:05:01 (UTC+00:00)
> >
> >> syzbot has bisected this bug to:
> >>
> >> commit 2af6106ae949651d529c8c3f0734c3a7babd0d4b
> >> Author: Jose Abreu <Jose.Abreu@synopsys.com>
> >> Date:   Tue Jul 9 08:03:00 2019 +0000
> >>
> >>      net: stmmac: Introducing support for Page Pool
> >
> > From the config provided, stmmac driver is not even enabled. Can you
> > please confirm the bisection process ?
>
> Looks like a false positive, as j1939 (net/can/j1939/) hit mainline with
> v5.4-rc1~131^2~78^2.
>
> While the bisected commit is v5.3-rc1~140^2~13^2.


Yes, the commit is most likely irrelevant. As you can see in the
bisection log the process was diverged by "WARNING: ODEBUG bug in
netdev_freemem". I think it's not the first and not the second time I
see that crash breaks bisection:
https://syzkaller.appspot.com/bug?id=96a64fde216dca408a5c25db4e57838c51e435aa
