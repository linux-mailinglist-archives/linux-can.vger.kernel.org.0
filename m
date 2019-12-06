Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE26C114DD7
	for <lists+linux-can@lfdr.de>; Fri,  6 Dec 2019 09:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfLFI73 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Dec 2019 03:59:29 -0500
Received: from relay-b01.edpnet.be ([212.71.1.221]:50488 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfLFI73 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Dec 2019 03:59:29 -0500
X-ASG-Debug-ID: 1575622765-0a7ff5137e126f770001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (94.105.105.111.dyn.edpnet.net [94.105.105.111]) by relay-b01.edpnet.be with ESMTP id Z3dbCApwdtvE4CEz; Fri, 06 Dec 2019 09:59:25 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 94.105.105.111.dyn.edpnet.net[94.105.105.111]
X-Barracuda-Apparent-Source-IP: 94.105.105.111
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id D4655BA08DF;
        Fri,  6 Dec 2019 09:59:20 +0100 (CET)
Date:   Fri, 6 Dec 2019 09:59:23 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Elenita Hinds <ecathinds@gmail.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: can-utils jacd questions
Message-ID: <20191206085923.GA4896@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: can-utils jacd questions
Mail-Followup-To: Elenita Hinds <ecathinds@gmail.com>,
        linux-can@vger.kernel.org
References: <CAHChkrstQdjVcWtvX4oeUOQfZS3-G_RPWb8Y82Zvaku40dM_qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHChkrstQdjVcWtvX4oeUOQfZS3-G_RPWb8Y82Zvaku40dM_qA@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 94.105.105.111.dyn.edpnet.net[94.105.105.111]
X-Barracuda-Start-Time: 1575622765
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 2223
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5017 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.78484
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

On do, 05 dec 2019 14:55:53 -0600, Elenita Hinds wrote:
> Hi all,
> 
> I am hoping to re-use the can-utils' jacd as default Address Claiming
> daemon but runs into some issues:
> 
> (1) " err(0, <string>, ...) " is called in several places, even though
> looking at the code logic, there is no error and the program should be
> able to continue. The program exits because err()  never returns.
> For example:

commit 791b6de7 introduced the problem.
it replaced all error(x, y, sss) calls with err(y, sss)
but it should have become warn(y, sss) when x=0.

Feel free to fix that.

> (2) The socket is configured to also set the SO_BINDTODEVICE option.
> In our system, this requires the program to have root permissions to
> run but we'd rather not do this for security reasons. Is this option
> required? What are the side-effects if this option is not set? Can it
> be made optional such that the program does not exit if the
> setsockoption(SO_BINDTODEVICE) call fails (seems to work without it)?

It appears on first sight that SO_BINDTODEVICE isn't strictly necessary
since bind() will have sockaddr_can.can_ifindex set anyway.
In that case, rather then ignore the result,
remove the call to SO_BINDTODEVICE completely.

> 
> (3) The claimed address is only saved to a file when the program
> terminates.  What is the reason for this? Can it not be saved after
> one is claimed already so that another process can  read it real-time
> if needed?

That should not be necessary.
At time of writing jacd, you could consult 'ip addr show can0' to find
out. I'm not sure what option remained to find it.
I believe you can, from another program, bind() with the same name, and
then getsockname() will return the complete sockaddr_can with SA filled
in.

> Also, in cases of a program crash or a power outage, the
> claimed address is still saved.

That is a true remark.
Given a power outage (the program never crashes :-) ),
and looking at the code, +10 years later, I would now write to a temp file,
and rename() the file to make it an atomic operation.
Doing that regularly, or upon change, would be an improvement.

Kurt
> 
> 
> Thanks in advance,
> Elenita
