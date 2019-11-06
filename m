Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD040F1559
	for <lists+linux-can@lfdr.de>; Wed,  6 Nov 2019 12:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfKFLmP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Wed, 6 Nov 2019 06:42:15 -0500
Received: from relay-b02.edpnet.be ([212.71.1.222]:41686 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfKFLmO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 6 Nov 2019 06:42:14 -0500
X-Greylist: delayed 1095 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Nov 2019 06:42:13 EST
X-ASG-Debug-ID: 1573039436-0a7b8d13bf1ae5830001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.119.173.adsl.dyn.edpnet.net [77.109.119.173]) by relay-b02.edpnet.be with ESMTP id i1LiX8ePh3qa4H1x; Wed, 06 Nov 2019 12:23:56 +0100 (CET)
X-Barracuda-Envelope-From: kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.173.adsl.dyn.edpnet.net[77.109.119.173]
X-Barracuda-Apparent-Source-IP: 77.109.119.173
Received: from [10.44.12.183] (unknown [188.188.76.183])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id EEF64AED7BB;
        Wed,  6 Nov 2019 12:23:53 +0100 (CET)
Date:   Wed, 06 Nov 2019 12:23:55 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <7e91f790-22f5-070c-f56d-a432779c7e4d@hartkopp.net>
References: <CADNXvDw5KDju9pHaRY1_6T-GgoOo=T2i4FZJRvd0GuP0jZis=g@mail.gmail.com> <CADNXvDy5qj0=tUQ1h_aN4UuCRtnXQ+4y55+JSKneyx9-C1CyBA@mail.gmail.com> <7e91f790-22f5-070c-f56d-a432779c7e4d@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: Fwd: Return value of write() in BUS-OFF state
To:     Oliver Hartkopp <socketcan@hartkopp.net>, jara.beran@gmail.com,
        linux-can@vger.kernel.org
X-ASG-Orig-Subj: Re: Fwd: Return value of write() in BUS-OFF state
From:   Kurt Van Dijck <kurt@vandijck-laurijssen.be>
Message-ID: <D5447E34-0D39-470F-A4FF-D9530F91359E@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.119.173.adsl.dyn.edpnet.net[77.109.119.173]
X-Barracuda-Start-Time: 1573039436
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 2065
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5340 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77843
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 6 November 2019 12:12:39 GMT+01:00, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>Hello Jaroslav,
>
>On 05/11/2019 22.46, Jaroslav Beran wrote:
>
>> So far I've learned this issue is most probably caused by upper (net
>> and can) layers (so this is not specific for certain controller
>> driver). When a driver calls can_bus_off, it sets carrier-off and
>> triggers linkwatch_* actions that deactivate net queues and
>substitute
>> a struct qdisc with `noop_qdisc`. Upon sending a frame, it's enqueue
>> function - noop_enqueue - just returns NET_XMIT_CN, which is
>> transformed by net_xmit_errno macro to zero, that's passed by
>> net/can/af_can.c:can_send up to a userspace caller of write as
>> success.
>
>Hm.
>
>> According to description for qdisc return codes in
>> include/linux/netdevice.h, NET_XMIT_CN stands for `congestion
>> notification` and further
>> 
>> /* NET_XMIT_CN is special. It does not guarantee that this packet is
>lost. It
>>   * indicates that the device will soon be dropping packets, or
>already drops
>>   * some packets of the same priority; prompting us to send less
>aggressively. */
>> 
>> 
>> Is this behavior appropriate for a node in BUS-OFF state? I'd rather
>> expect such controller would be always dropping all frames (not just
>> soon and some) until reset.
>
>The common use of the net_xmit_errno macro probably really does not fit
>
>to the CAN specialties ...
>
>> In current situation a caller of write gets success even if his frame
>> is lost for sure. Is there any specific reason for this? Of course he
>> can be notified by receiving error frame, but why don't just return
>> error in can_send?
>
>Yes. It makes sense to forward the carrier-off state that is thankfully
>
>provided by the linkwatch triggers to the user space.
>
>Looking to man(2) send we should provide -ENOBUFS in the case of 
>carrier-off state, right?
ENOBUFS seems a bad indication. What about ENETDOWN instead?
>
>Would you like to provide a patch?
>
>Best regards,
>Oliver
