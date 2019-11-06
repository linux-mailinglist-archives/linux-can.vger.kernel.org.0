Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF72F2142
	for <lists+linux-can@lfdr.de>; Wed,  6 Nov 2019 22:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfKFV7t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Wed, 6 Nov 2019 16:59:49 -0500
Received: from relay-b03.edpnet.be ([212.71.1.220]:56763 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfKFV7t (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 6 Nov 2019 16:59:49 -0500
X-ASG-Debug-ID: 1573077586-0a881812f61488870001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.119.173.adsl.dyn.edpnet.net [77.109.119.173]) by relay-b03.edpnet.be with ESMTP id Gm6if6GXU68zR9of; Wed, 06 Nov 2019 22:59:46 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.173.adsl.dyn.edpnet.net[77.109.119.173]
X-Barracuda-Apparent-Source-IP: 77.109.119.173
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id DD0E6AF0799;
        Wed,  6 Nov 2019 22:59:43 +0100 (CET)
Date:   Wed, 6 Nov 2019 22:59:43 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Jaroslav Beran <jara.beran@gmail.com>, linux-can@vger.kernel.org
Subject: Re: Fwd: Return value of write() in BUS-OFF state
Message-ID: <20191106215943.GA5341@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: Fwd: Return value of write() in BUS-OFF state
Mail-Followup-To: Oliver Hartkopp <socketcan@hartkopp.net>,
        Jaroslav Beran <jara.beran@gmail.com>, linux-can@vger.kernel.org
References: <CADNXvDw5KDju9pHaRY1_6T-GgoOo=T2i4FZJRvd0GuP0jZis=g@mail.gmail.com>
 <CADNXvDy5qj0=tUQ1h_aN4UuCRtnXQ+4y55+JSKneyx9-C1CyBA@mail.gmail.com>
 <7e91f790-22f5-070c-f56d-a432779c7e4d@hartkopp.net>
 <D5447E34-0D39-470F-A4FF-D9530F91359E@vandijck-laurijssen.be>
 <f11ebe09-1ce9-0b4c-2c6c-f6a0d2383696@hartkopp.net>
 <CADNXvDzewkO8L-3LYNtt=JsMTmf8rw5uOaquF5mB2OS_5fKaTA@mail.gmail.com>
 <85e46c24-0b0c-3109-3ee9-07914cca6d7b@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <85e46c24-0b0c-3109-3ee9-07914cca6d7b@hartkopp.net>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.119.173.adsl.dyn.edpnet.net[77.109.119.173]
X-Barracuda-Start-Time: 1573077586
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 3718
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.7136 1.0000 1.4740
X-Barracuda-Spam-Score: 1.47
X-Barracuda-Spam-Status: No, SCORE=1.47 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77851
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On wo, 06 nov 2019 22:15:50 +0100, Oliver Hartkopp wrote:
> 
> 
> 
> On 06/11/2019 18.23, Jaroslav Beran wrote:
> >On Wed, Nov 6, 2019 at 3:26 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> >>
> >>
> >>
> >>On 06/11/2019 12.23, Kurt Van Dijck wrote:
> >>>
> >>>
> >>>On 6 November 2019 12:12:39 GMT+01:00, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> >>>>Hello Jaroslav,
> >>>>
> >>>>On 05/11/2019 22.46, Jaroslav Beran wrote:
> >>>>
> >>>>>So far I've learned this issue is most probably caused by upper (net
> >>>>>and can) layers (so this is not specific for certain controller
> >>>>>driver). When a driver calls can_bus_off, it sets carrier-off and
> >>>>>triggers linkwatch_* actions that deactivate net queues and
> >>>>substitute
> >>>>>a struct qdisc with `noop_qdisc`. Upon sending a frame, it's enqueue
> >>>>>function - noop_enqueue - just returns NET_XMIT_CN, which is
> >>>>>transformed by net_xmit_errno macro to zero, that's passed by
> >>>>>net/can/af_can.c:can_send up to a userspace caller of write as
> >>>>>success.
> >>>>
> >>>>Hm.
> >>>>
> >>>>>According to description for qdisc return codes in
> >>>>>include/linux/netdevice.h, NET_XMIT_CN stands for `congestion
> >>>>>notification` and further
> >>>>>
> >>>>>/* NET_XMIT_CN is special. It does not guarantee that this packet is
> >>>>lost. It
> >>>>>    * indicates that the device will soon be dropping packets, or
> >>>>already drops
> >>>>>    * some packets of the same priority; prompting us to send less
> >>>>aggressively. */
> >>>>>
> >>>>>
> >>>>>Is this behavior appropriate for a node in BUS-OFF state? I'd rather
> >>>>>expect such controller would be always dropping all frames (not just
> >>>>>soon and some) until reset.
> >>>>
> >>>>The common use of the net_xmit_errno macro probably really does not fit
> >>>>
> >>>>to the CAN specialties ...
> >>>>
> >>>>>In current situation a caller of write gets success even if his frame
> >>>>>is lost for sure. Is there any specific reason for this? Of course he
> >>>>>can be notified by receiving error frame, but why don't just return
> >>>>>error in can_send?
> >>>>
> >>>>Yes. It makes sense to forward the carrier-off state that is thankfully
> >>>>
> >>>>provided by the linkwatch triggers to the user space.
> >>>>
> >>>>Looking to man(2) send we should provide -ENOBUFS in the case of
> >>>>carrier-off state, right?
> >>>ENOBUFS seems a bad indication. What about ENETDOWN instead?
> >>
> >>ENETDOWN shows that the interface is "down" which does not fit the
> >>current situation.

ack. ENETDOWN was a bad suggestion.

> >>
> >>The interface is "up" but the carrier is "off".
> >>
> >>man(2) send says:
> >>
> >>ENOBUFS
> >>        The output queue for a network interface was full.  This  gener‐
> >>        ally  indicates  that the interface has stopped sending, but may
> >>        be caused by transient congestion.  (Normally, this does not oc‐
> >>        cur  in  Linux.  Packets are just silently dropped when a device
> >>        queue overflows.)
> >>
> >>Fits to me !?
> >>
> >
> >I don't know, neither option doesn't perfectly fit for the carrier-off
> >state to me.
> >
> >What about choosing another code like ENOSPC or EIO to distinguish
> >bus-off from other recoverable conditions?
> 
> I must admit that the ability to distinguish the return values would be
> cool.

ack. busoff is completely different from 'on buffers'

> 
> But when you check the man pages from either send() or write() you'll see
> that ENOSPC or EIO have a description that fit even worse.

ENETUNREACH? I'm just picking values that suit more.
> 
> Best,
> Oliver
