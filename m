Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1468119D814
	for <lists+linux-can@lfdr.de>; Fri,  3 Apr 2020 15:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgDCN6S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Fri, 3 Apr 2020 09:58:18 -0400
Received: from smtpx.feld.cvut.cz ([147.32.192.33]:33017 "EHLO
        smtpx.feld.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgDCN6S (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Apr 2020 09:58:18 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Apr 2020 09:58:17 EDT
Received: from localhost (styx [192.168.200.7])
        by smtpx.feld.cvut.cz (Postfix) with ESMTP id 4A07B2351F;
        Fri,  3 Apr 2020 15:53:11 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.feld.cvut.cz ([192.168.200.2])
        by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10060)
        with ESMTP id id1MOtceLwEl; Fri,  3 Apr 2020 15:53:08 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
        by smtpx.feld.cvut.cz (Postfix) with ESMTP id A3F6D233C9;
        Fri,  3 Apr 2020 15:53:08 +0200 (CEST)
Received: from wsh by steelpick.2x.cz with local (Exim 4.93)
        (envelope-from <michal.sojka@cvut.cz>)
        id 1jKMku-0003WM-0V; Fri, 03 Apr 2020 15:53:08 +0200
From:   Michal Sojka <michal.sojka@cvut.cz>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Andrejus =?utf-8?Q?Fal=C4=8Di?= =?utf-8?Q?kas?= 
        <andrejus.f@8devices.com>, socketcan@hartkopp.net
Cc:     linux-can@vger.kernel.org
Subject: Re: Fwd: usb_8dev - WARN_ON(in_irq()) Ticket #00560
In-Reply-To: <f17f8d95-96b4-4d51-4390-1fb6a1e47fc8@grandegger.com>
References: <CAFnz-BWK_c63YyZ2KzMq=EWn6yfEQyyX+Vo7WSh4SddyY7PCfQ@mail.gmail.com> <f17f8d95-96b4-4d51-4390-1fb6a1e47fc8@grandegger.com>
Date:   Fri, 03 Apr 2020 15:53:07 +0200
Message-ID: <871rp4he0s.fsf@steelpick.2x.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Wolfgang,

On Fri, Apr 03 2020, Wolfgang Grandegger wrote:
> Hello Andrejus,
>
> please do not remove the history of this conversation! It's very
> difficult to follow what you are speaking about...
>
> Am 03.04.20 um 15:04 schrieb Andrejus Falčikas:
>> Hello Mr. Oliver Hartkopp,
>> 
>> I would like to notify you that the case described as the issue is
>> caused by non-standard use of the device and protocol.

[...]

>
> I observe a similar problem with the GS_USB CAN controller and I have
> posted a patch recently here:
>
>   https://marc.info/?l=linux-can&m=158504888512764&w=2
>
> Could you please give the patch for your device below a try:

It would be great if Andrejus can try the patch. If not, I'll try it
after I get back to work where I have the device. Unfortunately, due to
current situation, I'm not sure when it will happen.

Thanks.
-Michal
