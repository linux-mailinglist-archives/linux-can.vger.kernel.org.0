Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE3A0B1A9C
	for <lists+linux-can@lfdr.de>; Fri, 13 Sep 2019 11:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387740AbfIMJRQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 13 Sep 2019 05:17:16 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:44438 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387424AbfIMJRQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 13 Sep 2019 05:17:16 -0400
X-ASG-Debug-ID: 1568366233-0a88186e2137c07a0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.114.181.adsl.dyn.edpnet.net [77.109.114.181]) by relay-b03.edpnet.be with ESMTP id 2CwyDqV0xhyDWDPb; Fri, 13 Sep 2019 11:17:13 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.114.181.adsl.dyn.edpnet.net[77.109.114.181]
X-Barracuda-Apparent-Source-IP: 77.109.114.181
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 5394C9C2C68;
        Fri, 13 Sep 2019 11:17:13 +0200 (CEST)
Date:   Fri, 13 Sep 2019 11:17:11 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     "Romain Forlot [IoT.bzh]" <romain.forlot@iot.bzh>
Cc:     linux-can@vger.kernel.org
Subject: Re: Signed signal value in CAN bus
Message-ID: <20190913091711.GA22960@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: Signed signal value in CAN bus
Mail-Followup-To: "Romain Forlot [IoT.bzh]" <romain.forlot@iot.bzh>,
        linux-can@vger.kernel.org
References: <2cea4753-c7b6-94a7-360f-30534591fd9f@iot.bzh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2cea4753-c7b6-94a7-360f-30534591fd9f@iot.bzh>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.114.181.adsl.dyn.edpnet.net[77.109.114.181]
X-Barracuda-Start-Time: 1568366233
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1143
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5128 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.76373
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,
On vr, 13 sep 2019 10:38:23 +0200, Romain Forlot [IoT.bzh] wrote:
> Hi everyone,
> 
> I have a question about signed numbers in CAN, but I try to handle sign of a
> signal's value whenever it is a signed value.
> 
> I would like to have something that works in any cases obviously but for
> what I found, signed value in CAN bus isn't standardized.
> 
> You can have:
> 
>  * signal on N-1 bits, with the subtracted bit representing the sign
>  * either with 1's complement
>  * or 2's complement.
> 
> You could have some bitfield not encoded within classics bytes but in 3 or
> 13 bits by example, so it could complicate the computing of the signed value
> depending on the chosen method.

A common method is to define a range, like -1000 to 1000 to be encoded
into 0..2000 unsigned.
In this example, you require 11bits.
The advantages of doing so are:
1) it's not so difficult to convert to/from bitfields, i.e.
   as you found, properly decoding a negative number from an 11bit value
   is a bit obscure.
2) it leaves explicit room for special/fault codes, above the defined range.

Kind regards,
Kurt

