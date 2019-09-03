Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29A16A6DC3
	for <lists+linux-can@lfdr.de>; Tue,  3 Sep 2019 18:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbfICQQm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 3 Sep 2019 12:16:42 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21]:34011 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbfICQQm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 3 Sep 2019 12:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1567527397;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=+zJnPAMUgASlcmRFtfDhjdycTI4i5Cc65NjQzXvzszw=;
        b=TiJY912XS4mwx4yPtrdxp3ZLj+Ld83R7OanUD9vrfTUEMVS/UkAk9fEXFf7axLCp/O
        vxUs67ErHbcUfkQPCQbzJQtlvA92d1/CEgBqqvKeyPbpd9aGvKifFZynqOo8IZw1mn3A
        I/EEmL5NgY0dJP5UfutdMq1GV5LVhUfltOpj7Mv/FlEODOvJ79j4RzIq3XXO8/nPTZ4+
        8O9gKlISe7xKzRcAGUTnUcH9SP71bLyEEXt9+QWlYXtafQe/UqGLJ9cDQe50ZF0br0fT
        zWwD/wBiAmchEQkxzEFJHv/jcwb8Y9e89emYeXvwJ9jHWAwUOKfMaVZjDtZJ55NzZ3Z5
        5wLQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1r27UaEWJ+6BEwpjB"
X-RZG-CLASS-ID: mo00
Received: from [172.31.14.27]
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id j0667fv83GGbOKl
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 3 Sep 2019 18:16:37 +0200 (CEST)
Subject: Re: [PATCH 00/21] Add support for the J1939 Protocol
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de
References: <20190828065226.23604-1-mkl@pengutronix.de>
 <a101ddf0-5150-dd48-e456-3571cfc7036b@hartkopp.net>
 <80f42661-48d3-09a0-3323-8ac4a0bda74a@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <c3ed7db0-3d80-a17c-6c9e-0a4f821ed5db@hartkopp.net>
Date:   Tue, 3 Sep 2019 18:16:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <80f42661-48d3-09a0-3323-8ac4a0bda74a@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

yes I've gone through most of it.

Some patches do not work alone out of that sequence. Does it make sense 
to squash them into one?

squash patches 1-4 into one ?
5 ok
squash patches 6-7 into one ?
squash patches 8-9 into one ?
10 ok
11 ok - but my mail address is wrong :/
12 already ok
squash patches 13-15 into one ?
16-17 ok
18 Shouldn't it be CAN_REQUIRED_SIZE() ??
19-21 ok

ok -> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

I'll take a closer look into 21 - but no need to slow down the upstream 
process for that.

Best,
Oliver

On 03/09/2019 11.26, Marc Kleine-Budde wrote:
> On 8/28/19 11:56 AM, Oliver Hartkopp wrote:
>> Hi Marc,
>>
>> this series only refactores & prepares the PF_CAN infrastructure to add
>> the J1939 support ;-)
>>
>> Btw. I think I can find some time for a review on Friday.
> 
> Have you found time to look at the patches?
> 
> regards,
> Marc
> 
