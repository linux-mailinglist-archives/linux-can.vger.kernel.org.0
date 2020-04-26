Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B3D1B9404
	for <lists+linux-can@lfdr.de>; Sun, 26 Apr 2020 22:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgDZUrp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 26 Apr 2020 16:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726176AbgDZUro (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Apr 2020 16:47:44 -0400
X-Greylist: delayed 1809 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 26 Apr 2020 13:47:44 PDT
Received: from relay.felk.cvut.cz (relay.felk.cvut.cz [IPv6:2001:718:2:1611:0:1:0:70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20B05C061A0F
        for <linux-can@vger.kernel.org>; Sun, 26 Apr 2020 13:47:43 -0700 (PDT)
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by relay.felk.cvut.cz (8.15.2/8.15.2) with ESMTP id 03QKFbWV025626;
        Sun, 26 Apr 2020 22:15:37 +0200 (CEST)
        (envelope-from pisa@cmp.felk.cvut.cz)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 03QKFbG7016244;
        Sun, 26 Apr 2020 22:15:37 +0200
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 03QKFblP016243;
        Sun, 26 Apr 2020 22:15:37 +0200
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to pisa@cmp.felk.cvut.cz using -f
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     "Lev R. Oshvang ." <levonshe@gmail.com>
Subject: Re: Are there any netfilter modules for use with Socket CAN
Date:   Sun, 26 Apr 2020 22:15:36 +0200
User-Agent: KMail/1.9.10
Cc:     linux-can@vger.kernel.org,
        Rostislav =?utf-8?q?Lisov=C3=BD?= <lisovy@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>
References: <CAP22eLGTc6K1auF5JOofTKy83uTOq0hK_qb8fgJ=J78njwWjVA@mail.gmail.com>
In-Reply-To: <CAP22eLGTc6K1auF5JOofTKy83uTOq0hK_qb8fgJ=J78njwWjVA@mail.gmail.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202004262215.36557.pisa@cmp.felk.cvut.cz>
X-FELK-MailScanner-Information: 
X-MailScanner-ID: 03QKFbWV025626
X-FELK-MailScanner: Found to be clean
X-FELK-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
        score=-0.222, required 6, BAYES_00 -0.50, KHOP_HELO_FCRDNS 0.28,
        SPF_HELO_NONE 0.00, SPF_NONE 0.00)
X-FELK-MailScanner-From: pisa@cmp.felk.cvut.cz
X-FELK-MailScanner-Watermark: 1588536939.06819@o5ldu/2iIfItKr/uP/P1WQ
X-Spam-Status: No
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Dear Lev,

On Sunday 26 of April 2020 14:07:08 Lev R. Oshvang . wrote:
> >From my google search I did not find any netfilter /iptable rule which
>
> allows to filter on CAN fields,  message ID and other.
> Please point me in the right direction.

I am not sure if this can help, but Rostislav Lisovy
has implemented linux-devel/net/sched/em_canid.c
which has been merged around Linux kernel version 3.6
and is still there. It allows to classify CAN frames
for purpose of queening disciplines. There is report
with documentation how to use it

https://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf

I am not sure if this can be used for netfilter.

For sure CAN Gateway allows separation of real and virtual
can network and full control on IDs which are passed.

Best wishes,
                Pavel
--
                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://dce.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/


