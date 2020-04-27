Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0D61BA4CB
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2020 15:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgD0Ncl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 27 Apr 2020 09:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgD0Ncl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 27 Apr 2020 09:32:41 -0400
Received: from relay.felk.cvut.cz (relay.felk.cvut.cz [IPv6:2001:718:2:1611:0:1:0:70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 518FDC0610D5
        for <linux-can@vger.kernel.org>; Mon, 27 Apr 2020 06:32:40 -0700 (PDT)
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by relay.felk.cvut.cz (8.15.2/8.15.2) with ESMTP id 03RDUYf1024047;
        Mon, 27 Apr 2020 15:30:34 +0200 (CEST)
        (envelope-from pisa@cmp.felk.cvut.cz)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 03RDUYKC013358;
        Mon, 27 Apr 2020 15:30:34 +0200
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 03RDUYfF013357;
        Mon, 27 Apr 2020 15:30:34 +0200
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to pisa@cmp.felk.cvut.cz using -f
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     "Lev R. Oshvang ." <levonshe@gmail.com>
Subject: Re: Are there any netfilter modules for use with Socket CAN
Date:   Mon, 27 Apr 2020 15:30:33 +0200
User-Agent: KMail/1.9.10
Cc:     linux-can@vger.kernel.org,
        Rostislav =?utf-8?q?Lisov=C3=BD?= <lisovy@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>
References: <CAP22eLGTc6K1auF5JOofTKy83uTOq0hK_qb8fgJ=J78njwWjVA@mail.gmail.com> <202004262215.36557.pisa@cmp.felk.cvut.cz> <CAP22eLEq1FJWLgT+-NvG=geLiKeEasgz7WZFkhXYuTbeio2t8g@mail.gmail.com>
In-Reply-To: <CAP22eLEq1FJWLgT+-NvG=geLiKeEasgz7WZFkhXYuTbeio2t8g@mail.gmail.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202004271530.33887.pisa@cmp.felk.cvut.cz>
X-FELK-MailScanner-Information: 
X-MailScanner-ID: 03RDUYf1024047
X-FELK-MailScanner: Found to be clean
X-FELK-MailScanner-SpamCheck: not spam, SpamAssassin (not cached, score=-0.1,
        required 6, BAYES_00 -0.50, KHOP_HELO_FCRDNS 0.40,
        SPF_HELO_NONE 0.00, SPF_NONE 0.00)
X-FELK-MailScanner-From: pisa@cmp.felk.cvut.cz
X-FELK-MailScanner-Watermark: 1588599037.28557@/QC6f5j2wT3r23fzecskGg
X-Spam-Status: No
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Lev,

On Monday 27 of April 2020 12:31:36 Lev R. Oshvang . wrote:
> On Sun, Apr 26, 2020 at 11:17 PM Pavel Pisa <pisa@cmp.felk.cvut.cz> wrote:
> > Dear Lev,
> >
> > On Sunday 26 of April 2020 14:07:08 Lev R. Oshvang . wrote:
> > > >From my google search I did not find any netfilter /iptable rule which
> > >
> > > allows to filter on CAN fields,  message ID and other.
> > > Please point me in the right direction.
> >
> > I am not sure if this can help, but Rostislav Lisovy
> > has implemented linux-devel/net/sched/em_canid.c
> > which has been merged around Linux kernel version 3.6
> > and is still there. It allows to classify CAN frames
> > for purpose of queening disciplines. There is report
> > with documentation how to use it
> >
> > https://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf
> >
> > I am not sure if this can be used for netfilter.
> >
> > For sure CAN Gateway allows separation of real and virtual
> > can network and full control on IDs which are passed.
>
> Hi Pavel,
> Thanks for the info.
> I read again cangw man page. It clearly states that filter might be
> applied to incoming CAN traffic.
> It does not answer my question of whether anybody uses Netfilter for
> outgoing CAN messages?

the use described in our report is for outgoing traffic to classify
CAN frames to different output queues according to IDs to resolve
different kind of buffering of different kind of CAN traffic.
I.e. for best effort RT data ensure that only last one
is sent and previous are forgottent if not sent in a time.
For service data ensure that FIFO depth is long enough
to hold all data etc.

If I remember, it could be used to block some applications
or nodes to send some IDs etc...

What is your idea, need for use?

Best wishes,

Pavel
