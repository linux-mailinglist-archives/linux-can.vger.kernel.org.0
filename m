Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2FCEF46C
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2019 05:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbfKEETI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 4 Nov 2019 23:19:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63866 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729711AbfKEETH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 4 Nov 2019 23:19:07 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ABF58213F0;
        Mon,  4 Nov 2019 23:19:05 -0500 (EST)
        (envelope-from daniel.santos@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=av1lnHToyGo6
        FmR0FJnwAm38bwA=; b=gb2BK17TuDHrGYDyWfdfL0vfQucBMKcASfqjetR/Klh+
        Rf7Fcx5whufGQUxaz3kE3BQ3e5rM4bNrct/S1M27lksYjJPZSnlf8o1im6Ww+HGD
        1rWrMGO52UicH4aJpW5QpZKhzJW3kjRyb57ZhSmH0gexZ0N98cNT27kVUaFJt6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KyKnPJ
        bX3gswXiS8DKlUabzrqMxMqEQlYxXwDRNU7Es/lKUWY55ORomz5ZgROjHF7I0Jwq
        e3RujiEd+8rA1wI90M3baHhO8+TK0K3FwIAH/KWXuDcq1n8ngAPyH+51akbDbP+V
        V9ERsrBmDWomavE6Fv4SBT/RbxWdqgFqi9aDw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9ECEE213EF;
        Mon,  4 Nov 2019 23:19:05 -0500 (EST)
        (envelope-from daniel.santos@pobox.com)
Received: from [192.168.0.8] (unknown [76.85.7.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D951213EE;
        Mon,  4 Nov 2019 23:19:04 -0500 (EST)
        (envelope-from daniel.santos@pobox.com)
Subject: Re: CAN FD support in slcan - protocol extension?
To:     Jacob Schloss <jacob.schloss@suburbanembedded.com>
Cc:     Jeroen Hofstee <jhofstee@victronenergy.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <CACj_+4Y8904tbswy76Fpp6wGKZPdNpSrfDq6BvfTAGzs4zHT8w@mail.gmail.com>
 <97900bc5-48cc-b167-203d-ec7735009009@victronenergy.com>
 <CACj_+4aLfS9frR-sVkr1YcpYk+3pMZ85ALOrMWN2k=pVwJDLJw@mail.gmail.com>
 <3839c2b0-e6d3-98db-f774-6165f0c1cdcc@victronenergy.com>
 <5d51f507-d52d-2711-ef8e-180402f3dade@pobox.com>
 <CACj_+4ZmGEphoH0iu8jyemO3y25S7WtqgPLH1h6oFj46KegRog@mail.gmail.com>
From:   Daniel Santos <daniel.santos@pobox.com>
Message-ID: <60486fef-f18d-1c3a-a0ef-c3dd673cdf6c@pobox.com>
Date:   Mon, 4 Nov 2019 22:15:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACj_+4ZmGEphoH0iu8jyemO3y25S7WtqgPLH1h6oFj46KegRog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Pobox-Relay-ID: 67294854-FF83-11E9-802B-C28CBED8090B-06139138!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Jacob,

On 11/4/19 3:29 PM, Jacob Schloss wrote:
>> I have been forced to modify the USB protocol because I need get 2Mbps
>> of CAN to work on FS USB and the current protocol won't get there.  I
>> cobbled together a crude bit-packed mechanism, but I had forgotten abo=
ut
>> the FD CAN 64-byte payload scenario!  Since this is still in flux it
>> would be a perfect time to design a better protocol.  I haven't used
>> slcan and I don't know about it's protocol, other than it would have t=
o
>> be ascii-based.
>>
>> Given all of this, I *think* I'll design the USB protocol to always
>> re-submit dropped bulk IN URBs and drop any CAN/FD frames that are
>> received in excess of the device's internal buffer.  I *think* I would
>> rather do that than design a re-sync mechanism for when a bulk IN URB =
is
>> dropped (i.e., instead of dropping the frames in that failed URB).
>>
>> I'm working by the general assumption that the device is attached to a
>> hub that is HS and that the bottleneck will be between the device and
>> the first hub.
>>
>> Daniel
>>
> Hi Daniel,
>
> Sounds interesting, I'll take a look at the repo, and will look at
> what it would take for my firmware to be multi-protocol.

I'll be doing a destructive commit to master soon and my USB protocol is
not currently working correctly.=C2=A0 I've tagged where I am for histori=
cal
purposes as original-master, but it's not pretty at the moment.


> I suppose
> stream sync loss will be rare, and could do a USB reset as a worst
> case recovery. This is my first USB device, so haven't done much error
> / stream sync recovery on USB yet, just UART where I needed explicit
> synchronization.

Well I haven't thoroughly analyzed this yet, but my current notation is
adding a serial number to each URB, probably 8-bits, for ordering.=C2=A0
iirc, bulk URBs are only dropped when there is insufficient bandwidth
because they don't get allocated bandwidth like isochonus URBs do --
something I'm generally not counting.=C2=A0 (I don't consider myself a=C2=
=A0 USB
expert, so if anything I say is wrong please correct me.)=C2=A0 I'm only
planning on supporting this from device to host for now, since the heavy
throughput will almost always be when used as a sniffer.=C2=A0 Host to de=
vice
I'm leaving as-is.

So my current notion is to just queue up out-of-order bulk IN URBs on
the host side and wait until any missing ones are retransmitted in order
to resume the stream.

> I need to do some more hardening on my device side.
> It would be difficult for my code as-is to resync on a failed USB
> packet since the payload is just dumped in a FIFO that the app is
> waiting on and the application part doesn't even really know it is USB
> or where the packet boundaries are. Probably just need to add some
> event hooks for errors the app can use.
>
> - Jacob
>
I don't like how frame buffers work in candleLight or candy right now at
all.=C2=A0 I'll restructure this when I implement the FD CAN support.

Daniel
