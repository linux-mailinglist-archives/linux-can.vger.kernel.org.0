Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D15636A193
	for <lists+linux-can@lfdr.de>; Tue, 16 Jul 2019 06:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733149AbfGPEgk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 16 Jul 2019 00:36:40 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41227 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733086AbfGPEgj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 Jul 2019 00:36:39 -0400
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1hnFCg-00034Z-Oa; Tue, 16 Jul 2019 06:36:38 +0200
Subject: Re: J1939 : Address Claiming
To:     Arthur Guyader <arthur.guyader@iot.bzh>, linux-can@vger.kernel.org,
        dev.kurt@vandijck-laurijssen.be
References: <43c0a773-ec06-5288-9fcc-9cdf68e72879@iot.bzh>
 <20190706050020.GE22538@x1.vandijck-laurijssen.be>
 <f95b8200-31fa-e2f5-49a2-f576fae3cc9c@iot.bzh>
 <20190708084934.GA24954@x1.vandijck-laurijssen.be>
 <81056b49-a0c7-8b2d-d2d2-785b6107fd9d@iot.bzh>
 <a0d48616-86ac-a2f3-8d07-e0209e6f2021@iot.bzh>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <e6ea6de2-e21d-04d2-656b-c71b68dbaa7f@pengutronix.de>
Date:   Tue, 16 Jul 2019 06:36:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <a0d48616-86ac-a2f3-8d07-e0209e6f2021@iot.bzh>
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

Hi Arthur,

On 15.07.19 16:15, Arthur Guyader wrote:
> Hello,
> 
> I encountered a problem when using the claiming address.
> When an ECU1 with a low name requests an address, it is saved in the kernel cache.
> If this ECU1 is cut, and we launch our ECU2 which will ask for the same address.
> He will have no answer from ECU1 and has no trace of him in his cache, so he can consider 
> that the address is free.
> However, the kernel will consider that the address is busy and generate an error when 
> sending a message. (99 : cannot assign requested address)
> 
> How would you handle this situation?

You are describing a broken system. Is it a theoretical question or you was able to 
reproduce it with latest j1939 stack?

> I thought about sending a test message and handling the error case and choosing another 
> address.
> 
> Is there any way to clear the kernel cache?

No. You can send an address claim message with idle address.

Kind regards,
Oleksij Rempel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
