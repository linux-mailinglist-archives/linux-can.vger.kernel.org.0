Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12D381624DF
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2020 11:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgBRKrB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Feb 2020 05:47:01 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56003 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgBRKrB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Feb 2020 05:47:01 -0500
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1j40P5-0006yl-J0; Tue, 18 Feb 2020 11:46:59 +0100
Subject: Re: J1939: Unable to receive and transmit multi-frame messages
To:     Elenita Hinds <ecathinds@gmail.com>, linux-can@vger.kernel.org
References: <CAHChkrtxFyzZz2yTAOvui=-j5QA3=2_Qoe6whWe+TDzZJk4QVA@mail.gmail.com>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <b7ed0f9e-117b-9555-8420-6cb41315a9b7@pengutronix.de>
Date:   Tue, 18 Feb 2020 11:46:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHChkrtxFyzZz2yTAOvui=-j5QA3=2_Qoe6whWe+TDzZJk4QVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

On 17.02.20 21:49, Elenita Hinds wrote:
> Hi,
> 
> Back when I was using just the J1939 branch (before it got re-written
> and mainlined), I was able to receive and transmit multi-frame
> messages.  Upgrading to kernel v5.4, this is no longer the case.

The upstreamed version is not binary compatible to the old version. Please make sure your 
application is properly updated.

> For the receive part, it is failing in j1939_tp_im_involved_anydir()
> call, which is the first thing called by j1939_tp_recv(). The socket
> is set to promiscuous mode; has no problem receiving ALL the  8-byte
> long messages but fails on longer ones. There should not be any
> difference with how the socket is setup as far as the message length
> goes  but is there a new step needed in order to receive the
> multi-frame messages as well?

The TP/ETP (multi-frame message) is the core functionality of j1939 stack. The 
functionality can be tested with cat-utils. See:
https://github.com/linux-can/can-utils/blob/master/can-j1939-kickstart.md

Please make sure you have all recent fixes:
https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/net/can/j1939

If you still have some issue, please provide code example, so we able to reproduce it.

Kind regards,
Oleksij Rempel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
