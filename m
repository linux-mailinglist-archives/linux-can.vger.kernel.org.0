Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A722BA996
	for <lists+linux-can@lfdr.de>; Fri, 20 Nov 2020 12:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgKTLux (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 Nov 2020 06:50:53 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:11113 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbgKTLuw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Nov 2020 06:50:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1605873050;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=w+69ynIVHYgtXNajzNR0R4G1dvZV5a/1GupiBpqmGBc=;
        b=Uy+SA01Y0MYNNW/s96A874+dM5xA9vJtSNyFpwwxrRVeSoK+R3+zKqXD1Uak1Lzvpv
        Iwczi9nowRErAJLZMQY+sOXYlKiX1R4WbeUqhQ1eSvjSc+ukqu5ofFIk+kYXFUcGZUZD
        h2JhuL5Rjpg+wR8t2yI9fffvQFznYgjRdI46UnUHAomrMQoS5+qKxrX1q6I8IgZYt6Dx
        Ck4zb7T23w5/OVjCPbbQw6ENgBFy2mWWQ4xVRoKVh3e0atrUH+NBEPNqZ2S+4kxuo8b1
        CB35sDbvhlOtHzPmq9215zPeOtGJ6Ey+WJpOeUwpDgF5jmUMlrnnHJpJSCcjZqkRrmbi
        YROQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGV1iOMlqpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id n07f3bwAKBooXEN
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 20 Nov 2020 12:50:50 +0100 (CET)
Subject: Re: [net] can: gs_usb: fix endianess problem with candleLight
 firmware
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Maximilian Schneider <max@schneidersoft.net>,
        Hubert Denkmair <hubert@denkmair.de>,
        Michael Rausch <mr@netadair.de>
References: <20201120103818.3386964-1-mkl@pengutronix.de>
 <9872e561-ddb5-4d0f-4d7c-fa74269f1208@hartkopp.net>
 <47f185ce-020c-fe43-e317-3fdd9fb2e11e@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <868c694c-c56e-6620-7625-b369a7f15f5a@hartkopp.net>
Date:   Fri, 20 Nov 2020 12:50:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <47f185ce-020c-fe43-e317-3fdd9fb2e11e@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 20.11.20 12:39, Marc Kleine-Budde wrote:
> On 11/20/20 12:23 PM, Oliver Hartkopp wrote:
>>
>>
>> On 20.11.20 11:38, Marc Kleine-Budde wrote:
>>> The firmware on the original USB2CAN by Geschwister Schneider Technologie
>>> Entwicklungs- und Vertriebs UG exchanges all data between the host and the
>>> device in host byte order. This is done with the struct
>>> gs_host_config::byte_order member, which is sent first to indicate the desired
>>> byte order.
>>>
>>> The widely used open source firmware candleLight doesn't support this feature
>>> and exchanges the data in little endian byte order. This breaks if a device
>>> with candleLight firmware is used on big endianess systems.
>>
>> Looks like this problem showed up pretty late.
> 
> There are not that many BE users out there...
> 
>> Won't it be better to implement the feature in the candlelight firmware
>> so that only the big endian users need to upgrade the candlelight
>> firmware instead of disabling this nice feature?
> 
> It's easier to update the Linux driver, for LE Linux host systems this is
> basically a no-op.

Ok. And with these changes

 >   struct gs_host_config {
 > -	u32 byte_order;
 > +	__le32 byte_order;
 >   } __packed;


 >
 > -	hconf->byte_order = 0x0000beef;
 > +	hconf->byte_order = cpu_to_le32(0x0000beef);
 >

the original GS_USB hardware is pinned to always provide little endian, 
right?

