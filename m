Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9609125FAF5
	for <lists+linux-can@lfdr.de>; Mon,  7 Sep 2020 15:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgIGNHh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 7 Sep 2020 09:07:37 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:43077 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729351AbgIGNH3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Sep 2020 09:07:29 -0400
Received: from p1.motec.com.au (n175-33-166-74.meb2.vic.optusnet.com.au [175.33.166.74])
        (Authenticated sender: thomasaevans@optusnet.com.au)
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPA id 3D1E6824378;
        Mon,  7 Sep 2020 23:07:01 +1000 (AEST)
Reply-To: tom_usenet@optusnet.com.au
Subject: Re: Questions about using multiple sockets
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        henrique ricardo figueira <henrislip@gmail.com>,
        linux-can@vger.kernel.org
References: <CAD1tVCN7-T=FHNQEz3Bp-0Kt3H6M1RokyUuw=e9sTLdXNWB=DQ@mail.gmail.com>
 <20200903054724.x6giher7ldmuvbac@pengutronix.de>
 <1116be40-25c4-002e-8455-5d5f86ac6e03@optusnet.com.au>
 <ebbe3d01-f36b-78e5-3a73-eee7f868b464@hartkopp.net>
 <20200907123356.GA15060@x1.vandijck-laurijssen.be>
From:   Tom Evans <tom_usenet@optusnet.com.au>
Message-ID: <18093198-d04c-e07e-9a92-306f9d0afbb7@optusnet.com.au>
Date:   Mon, 7 Sep 2020 23:07:00 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907123356.GA15060@x1.vandijck-laurijssen.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=XJ9OtjpE c=1 sm=1 tr=0 cx=a_idp_d
        a=sd228vxsjXR49agASWeIzg==:117 a=sd228vxsjXR49agASWeIzg==:17
        a=IkcTkHD0fZMA:10 a=RSmzAf-M6YYA:10 a=Ye9q-bpsAAAA:8
        a=neUsgK625uVJJ175li8A:9 a=QEXdDO2ut3YA:10
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 7/9/20 10:33 pm, Kurt Van Dijck wrote:
>>
>> The 'problem' seems to be already introduced by that specific ECU ;-)
> 
> In my experience, it's hard to use 29bit CAN id's mixed with J1939.
> But the 11bit CAN id range is free to use without any conflict with
> j1939.
> I've seen some uses of this 11bit id's.

Just as long as all other devices on the bus are perfect and fully tested, and don't do what was in 
one of the links I sent previously:

https://electronics.stackexchange.com/questions/467932/is-it-possible-to-use-j1939-and-canopen-on-the-same-bus

     Certain CAN nodes don't distinguish between 11 or 29 bit
     internally.

There are a lot of CAN devices out there that work well enough in the limited environment they've 
been tested in. But add anything else to the bus and change the traffic or addresses in use and you 
might find they can't handle that. They might be demonstrably buggy, but it will still be your 
fault. Especially if they throw a DTC and don't work until the vehicle gets back to the dealer to 
clear it. BeenThereDoneThat.

Tom
