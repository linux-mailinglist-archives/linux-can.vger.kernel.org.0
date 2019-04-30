Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8BEF90F
	for <lists+linux-can@lfdr.de>; Tue, 30 Apr 2019 14:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfD3Mjd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 30 Apr 2019 08:39:33 -0400
Received: from mail.iot.bzh ([51.75.236.24]:29818 "EHLO mail.iot.bzh"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbfD3Mjb (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 30 Apr 2019 08:39:31 -0400
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Apr 2019 08:39:30 EDT
Received: from shamash.uruk.home (171.186.30.109.rev.sfr.net [109.30.186.171])
        by mail.iot.bzh (Postfix) with ESMTPSA id E6C9240072;
        Tue, 30 Apr 2019 14:33:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iot.bzh; s=20180822;
        t=1556627640; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O8wTBZpWwukFGnYR+0IePx95uMcOqUjEuCgTuaBmj4E=;
        b=qbMZzuyoTx2jU1Nw4iV9TuS1eJTf4tBmI0nE/xTySxsCcKY+L5LhJDsmDUzQqZY5eLspt1
        8Um6GTQj2Z2Zp2Tt0S7ajjdr9s2D8MKD6gDMsWpWq4DM21DPmmIXg1K/hlNvjFnKchDIxL
        pXa4i2GcFy6hOo71xHzC1sp1PUYiuW6KOpIK+V3Mx06WzKB3IiGRa0F8FvpwMXH/zBCOzd
        bpz/AaDz3naYc+iC7p7iB9Vb9xXLg+ObihVy8A681j+aOVH7io5jz0uBa0gbPlYt9tXoSh
        JFxPtJi0DQuysPXzcKPpxBgzJs2nCjBFrGSDwaxLnmAvz9TonRWqTwht5DUZ6w==
Subject: Re: Managing endianness
To:     Andre Naujoks <nautsch2@gmail.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <88ea34d2-136f-73d2-bc43-d928cdf3a1a0@iot.bzh>
 <dd7da2fe-23bc-9013-80af-24b7a23ca7a7@gmail.com>
From:   Romain Forlot <romain.forlot@iot.bzh>
Organization: IoT.Bzh
Message-ID: <cda4f534-3ae8-14ab-6844-e71275936f56@iot.bzh>
Date:   Tue, 30 Apr 2019 14:33:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <dd7da2fe-23bc-9013-80af-24b7a23ca7a7@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------621AF6CA9DE826BCAF79F049"
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is a multi-part message in MIME format.
--------------621AF6CA9DE826BCAF79F049
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the reply, that's what I thought thanks for the confirmation. :)

On 12/04/2019 15:25, Andre Naujoks wrote:
> Am 12.04.19 um 14:40 schrieb Romain Forlot [IoT.bzh]:
>> Hi Oliver,
>>
>> I have a silly question about CAN signals retrieved from the Socketcan
>> stack. Is the endianness handled by Socketcan ? As endianness could be
>> only on a CAN signal so not on an entire CAN frame for what I saw from
>> some J1939 CAN messages definitions, I doubt that socketCAN handle that.
>> So it has to be handled by the user. Do you agree ?
> Not Oliver, but since this is addressed to the list.
>
> You are right, that socketcan does not handle endianness. You get an
> array of single bytes, which represent the bytes in the CAN-frame from
> front to back. If there are values spanning multiple bytes you have to
> take care of the endianness of those yourself.
>
> Regards
>    Andre
>
>> Thanks
>>
-- 
Romain Forlot - Embedded Engineer - IoT.bzh
romain.forlot@iot.bzh - www.iot.bzh - +33675142438


--------------621AF6CA9DE826BCAF79F049
Content-Type: text/x-vcard;
 name="romain_forlot.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="romain_forlot.vcf"

bnVsbA==
--------------621AF6CA9DE826BCAF79F049--
