Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6010625E5E0
	for <lists+linux-can@lfdr.de>; Sat,  5 Sep 2020 08:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgIEGrY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 5 Sep 2020 02:47:24 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:53513 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725818AbgIEGrY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 5 Sep 2020 02:47:24 -0400
Received: from p1.motec.com.au (n175-33-166-74.meb2.vic.optusnet.com.au [175.33.166.74])
        (Authenticated sender: thomasaevans@optusnet.com.au)
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPA id 418E83A76A4;
        Sat,  5 Sep 2020 16:47:19 +1000 (AEST)
Reply-To: tom_usenet@optusnet.com.au
Subject: Re: Questions about using multiple sockets
To:     henrique ricardo figueira <henrislip@gmail.com>
Cc:     linux-can@vger.kernel.org
References: <CAD1tVCN7-T=FHNQEz3Bp-0Kt3H6M1RokyUuw=e9sTLdXNWB=DQ@mail.gmail.com>
 <20200903054724.x6giher7ldmuvbac@pengutronix.de>
From:   Tom Evans <tom_usenet@optusnet.com.au>
Message-ID: <1116be40-25c4-002e-8455-5d5f86ac6e03@optusnet.com.au>
Date:   Sat, 5 Sep 2020 16:47:19 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903054724.x6giher7ldmuvbac@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=XJ9OtjpE c=1 sm=1 tr=0 cx=a_idp_d
        a=sd228vxsjXR49agASWeIzg==:117 a=sd228vxsjXR49agASWeIzg==:17
        a=IkcTkHD0fZMA:10 a=RSmzAf-M6YYA:10 a=Ye9q-bpsAAAA:8 a=pVMt_pm7AAAA:8
        a=auscOvPzMZT2EW-4ICkA:9 a=QEXdDO2ut3YA:10 a=MaASwASlnOjRF4zdGAmV:22
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 3/9/20 3:47 pm, Oleksij Rempel wrote:
> Hi Henrique,
> 
> On Wed, Sep 02, 2020 at 03:15:13PM -0300, henrique ricardo figueira wrote:
>> Hi, I would like to know if it is possible for me to use multiple sockets
>> with different protocols, a CAN_RAW socket and another CAN_J1939. Because I
>> need to receive messages from an ECU that does not follow J1939.
> 
> Yes, you can combine it as you wish. You can even use CAN_RAW to
> communicate with CAN_J1939 on same or remote machine.

Yes, as long as you open the sockets on DIFFERENT CAN Buses. One for the J1939 and a different bus 
for the ECU.

On the same bus?

CAN buses are usually "All J1939" or "All Something Else". The J1939 protocol uses all of the CAN ID 
field to mean a whole range of different things that are important to the protocol.

I'd suggest you look at the Wilipedia "SAE J1939" web page, and open the "Introduction to J1939 
(Vector Informatik)" link. It shows you how J1939 uses the CAN bus addresses.

It would be difficult to guarantee that the messages from the ECU won't upset one or more devices on 
the CAN bus.

Do you have full control of the ECU? Can you reprogram it to change the CAN IDs of all the messages 
it sends, or was that decided by someone else? If you can't change them then it is unlikely you 
could make it "compatible".

Then ask Google. This one says:

     If you are a CAN bus system design veteran (and only then),
     it is theoretically possible to combine them. It is a really
     bad idea but it can be done.

https://electronics.stackexchange.com/questions/467932/is-it-possible-to-use-j1939-and-canopen-on-the-same-bus

This one says "yes, but you have to do all of this...":

http://www.microcontrol.net/download/mmc_2013_koppe_2.pdf

The above also suggests that you should use a GATEWAY device between the two CAN buses. Or in your 
case, two buses on the computer.

I would say "yes, try this in an educational or hobby setup, but don't do it in a real vehicle".

Tom
