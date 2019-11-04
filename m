Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFFFED8F4
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2019 07:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfKDG0l (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 4 Nov 2019 01:26:41 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63699 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbfKDG0l (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 4 Nov 2019 01:26:41 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8BC818C374;
        Mon,  4 Nov 2019 01:26:36 -0500 (EST)
        (envelope-from daniel.santos@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=g6pwfsweywfs
        KX2p6bocRhlRKpM=; b=iFH6NL/acnaef03yciLXti8fR30Wle/dVxado1qz6riV
        WdWGjJ+PyZf354N/Dmz+nR8b2NgzH9bCZ4WkceBo4AFoRCfXm9X0zeBehA3xAKFd
        TCvtMdfvzAwlLYDKNvGiBnRdn1xPCGFZb5t+GMyK7XO8A81z37CglQt4arwSW34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=BDB638
        z/Tq9gk2ac9X9Mb41R5PZ1s4kOgMyF56bMlDpBHJ6Zj1/bPl07sWEOmu7F2KFRxz
        yoz+IphzdM41ogyyPTwee51RNkQTCp120/NH88JH6VDd2WrHOgnOGINaL0aY0iAk
        cm9EjzAK8a2TTo6tcflqsHEBDp2yLIagQmcsk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 784348C372;
        Mon,  4 Nov 2019 01:26:36 -0500 (EST)
        (envelope-from daniel.santos@pobox.com)
Received: from [192.168.0.8] (unknown [76.85.7.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B52738C371;
        Mon,  4 Nov 2019 01:26:33 -0500 (EST)
        (envelope-from daniel.santos@pobox.com)
Subject: Re: CAN FD support in slcan - protocol extension?
To:     Jeroen Hofstee <jhofstee@victronenergy.com>,
        Jacob Schloss <jacob.schloss@suburbanembedded.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <CACj_+4Y8904tbswy76Fpp6wGKZPdNpSrfDq6BvfTAGzs4zHT8w@mail.gmail.com>
 <97900bc5-48cc-b167-203d-ec7735009009@victronenergy.com>
 <CACj_+4aLfS9frR-sVkr1YcpYk+3pMZ85ALOrMWN2k=pVwJDLJw@mail.gmail.com>
 <3839c2b0-e6d3-98db-f774-6165f0c1cdcc@victronenergy.com>
From:   Daniel Santos <daniel.santos@pobox.com>
Message-ID: <5d51f507-d52d-2711-ef8e-180402f3dade@pobox.com>
Date:   Mon, 4 Nov 2019 00:22:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3839c2b0-e6d3-98db-f774-6165f0c1cdcc@victronenergy.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Pobox-Relay-ID: 0C00C00E-FECC-11E9-AFD9-B0405B776F7B-06139138!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello, and thank you for CCing me Jeroen.

I am working on firmware for CAN FD using the STM32G4xx line.=C2=A0 I've
forked candleLight_fw and am modifying the gs_usb driver.=C2=A0 In short,=
 my
immediate need is to have "classic" CAN working on this chip so we can
push a firmware update later when customers start needing FD CAN.=C2=A0 S=
o
while FD CAN isn't implemented yet, there are very few changes needed in
the firmware to support it (once classic CAN is done).=C2=A0 The firmware=
 is
still in a *very experimental* state, but if you like looking ugly code,
then: https://git.gsat.us/dansan/candy


On 10/31/19 2:41 PM, Jeroen Hofstee wrote:
> Hello Jacob,
>
> On 10/29/19 5:26 AM, Jacob Schloss wrote:
>> Hi Jeroen,
>>
>>> Are you aware of https://github.com/candle-usb/candleLight_fw?
>>> That uses a one on one binary version of the socketcan driver.
>>>
>>> That _might_ be straightforward to extend to FD. And that really
>>> is a might, since I don't know how it is implemented, but I would
>>> guess it is a flag.
>> I have used a device that used the candleLight_fw, but our board is
>> not compatible and we already have our own implementation of the
>> Lawicel text protocol working. I could add support for another
>> protocol, it looks like candlelight is dropping a struct defined here
>> https://github.com/candle-usb/candleLight_fw/blob/master/include/gs_us=
b.h,
>> padded out with zeros to fill a max size USB packet. I guess this is
>> the can/usb/gs_usb.c driver on Linux's side?
>
> It is indeed the gs_usb driver and send a struct as binary
> compatible with socketcan, it is not padded though. It also
> support status events / error counters / loopback etc.

In my firmware fork, I'm pulling in a number of headers from the Linux
kernel (making it GPL2), but I have a conflict with the license of ST's
USB stack (so I'll have to replace the USB stack we're using
eventually).=C2=A0 I plan on submitting a patch to separate out the commo=
n
structs and #defines in gs_usb.c into a include/linux/can/gs_usb.h (or
such) solely for the purpose of facilitating cleaner integration with
various firmware code.=C2=A0 Then I can just import or #include that into=
 the
firmware project.

>> I think it would be easier (for me at least) to extend the text mode
>> protocol used by net/can/slcan.c. It would also keep it possible to
>> use the device by hand in a pinch. Since I'm high speed USB, the extra
>> protocol overhead for ascii encoding seems ok.
>
> Understood, I have nothing against that. Only wanted to mention
> that there are other options..
>
>> Hmm. Extending both gs_usb.c and slcan.c for CAN FD might be useful :
>> ). For gs_host_frame, I guess what is needed is making the data field
>> longer and adding code to decode can_dlc and update appropriately
>> everywhere? I'm not sure if there is any other packet framing/header
>> or if it is assumed that a packet starts and finishes within a USB
>> transaction? A full size CAN FD packet doesn't fit in a single USB FS
>> packet, so would need a way to split across 2 USB FS packets. It might
>> force the protocol to look a bit different.
>>
> What could perhaps be done, is concatenate the messages,
> since the size is known. Some care has to be taken though
> how to get in "sync" again perhaps and likely some
> handshaking that both side support that. I think the kvaser
> does something similar.
>
> I haven't look at that in detail though, but it might be
> interesting for throughput reasons as well.
>
> With kind regards,
>
> Jeroen

I have been forced to modify the USB protocol because I need get 2Mbps
of CAN to work on FS USB and the current protocol won't get there.=C2=A0 =
I
cobbled together a crude bit-packed mechanism, but I had forgotten about
the FD CAN 64-byte payload scenario!=C2=A0 Since this is still in flux it
would be a perfect time to design a better protocol.=C2=A0 I haven't used
slcan and I don't know about it's protocol, other than it would have to
be ascii-based.

Given all of this, I *think* I'll design the USB protocol to always
re-submit dropped bulk IN URBs and drop any CAN/FD frames that are
received in excess of the device's internal buffer.=C2=A0 I *think* I wou=
ld
rather do that than design a re-sync mechanism for when a bulk IN URB is
dropped (i.e., instead of dropping the frames in that failed URB).

I'm working by the general assumption that the device is attached to a
hub that is HS and that the bottleneck will be between the device and
the first hub.

Daniel

