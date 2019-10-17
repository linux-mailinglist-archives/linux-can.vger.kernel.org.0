Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F08F9DB8DA
	for <lists+linux-can@lfdr.de>; Thu, 17 Oct 2019 23:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441371AbfJQVQJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Oct 2019 17:16:09 -0400
Received: from relay-b01.edpnet.be ([212.71.1.221]:39049 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441370AbfJQVQI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Oct 2019 17:16:08 -0400
X-ASG-Debug-ID: 1571346965-0a7ff54e9712d4fd0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.116.161.adsl.dyn.edpnet.net [77.109.116.161]) by relay-b01.edpnet.be with ESMTP id DpmCFJtsmFLWrxo9; Thu, 17 Oct 2019 23:16:05 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.116.161.adsl.dyn.edpnet.net[77.109.116.161]
X-Barracuda-Apparent-Source-IP: 77.109.116.161
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 75C13A7F178;
        Thu, 17 Oct 2019 23:16:05 +0200 (CEST)
Date:   Thu, 17 Oct 2019 23:16:04 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Elenita Hinds <ecathinds@gmail.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Subject: Re: c_can/d_can driver question
Message-ID: <20191017211604.GB27587@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: c_can/d_can driver question
Mail-Followup-To: Elenita Hinds <ecathinds@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <CAHChkrv6cKgNam-znKu_wOZm-y6gNkONmGWP6RFZpiSprq5_gQ@mail.gmail.com>
 <896bd824-1149-4229-a703-d2c946acd92b@pengutronix.de>
 <20191017074727.GA700@x1.vandijck-laurijssen.be>
 <CAHChkrsBMQy+=dQv-0JYqp7jrg3UvmQ_4JdR9WYrjAioNxfigw@mail.gmail.com>
 <CAHChkrs8iH4+2ZiQUjaD7B9CcqjfbeRG-_3R2uT+FWGSr5kGPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHChkrs8iH4+2ZiQUjaD7B9CcqjfbeRG-_3R2uT+FWGSr5kGPA@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.116.161.adsl.dyn.edpnet.net[77.109.116.161]
X-Barracuda-Start-Time: 1571346965
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 917
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5655 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77402
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hey,

On do, 17 okt 2019 15:37:04 -0500, Elenita Hinds wrote:
> I pulled in the c_can patches from the for-kurt branch (63574e9 thru
> bf01f717) and tested on my device.
> The number of overruns are noticeably fewer; however, the overall
> system performance seems to have slowed down. For example,
> the console response and Bluetooth data rate are noticeably slower.

You now give more precedence to CAN and less to console etc. ?
> 
> I also noticed that while the number of overruns decreased, the number
> of errors increased:

You have an interesting setup. I suspect that the FIFO is filled, and
does drop messages, although that is recorded in the statistics?

Would you want to try branch c_can-v4.9 in github.com/kurt-vd/linux?
I improved the reception a bit, and increased the FIFO size.

Besides that, can you give more details about your system and your load?

Kind regards,
Kurt
