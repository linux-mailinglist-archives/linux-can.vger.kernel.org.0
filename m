Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C793B3808
	for <lists+linux-can@lfdr.de>; Thu, 24 Jun 2021 22:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhFXUoB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Jun 2021 16:44:01 -0400
Received: from mout02.posteo.de ([185.67.36.66]:52823 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232029AbhFXUoB (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 24 Jun 2021 16:44:01 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 0A6112400FD
        for <linux-can@vger.kernel.org>; Thu, 24 Jun 2021 22:41:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1624567300; bh=h0whPnmsiYa4tdzpimBjmLYuvWf+lEo9a3Mb390imd4=;
        h=To:Cc:From:Autocrypt:Subject:Date:From;
        b=OKiszWktDpwpS18OUmpzfY0O90SdvEpcex+yqt9ia3tEdD4f+FsnMMhqsSfGw4vfL
         18InJ4GAUIu9J1LR7Ynz+Rx8HjnDt4b1tQKi3yUjD3XaXiTGN8gzgbPBWet7LbOhCh
         c3eJpSL/OI4nvUZxfowJ4YK3ZiiSFLewU8c3wRSiNUIzh4ql1ziZzH46a7OIPT1mM+
         yhkAweHW3GK+9ZFDBRsu0dxTMybWDu+dH943Hhs0TnfU/2IwSTLXELHygJkSJdcyUO
         QeOUpKI5+S76QuVLUNu4FoCiARKLgI8iem0zt0CznjCLl2bE5q/iFK8I7H3WGFrhWS
         mulT9vLw+zMlg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4G9sVq1yhKz6tm6;
        Thu, 24 Jun 2021 22:41:39 +0200 (CEST)
To:     Joshua Quesenberry <engnfrc@gmail.com>,
        'Marc Kleine-Budde' <mkl@pengutronix.de>
Cc:     kernel@pengutronix.de, linux-can@vger.kernel.org
References: <016701d7678c$2b3d50c0$81b7f240$@gmail.com>
 <20210622212818.enfx5fzgghfxfznb@pengutronix.de>
 <CAMGHUonufNF7CgAzcPkhgykxdYBtA+r5nY2i5xRGXN7Nxd5yMQ@mail.gmail.com>
 <2a99d742-b2dc-4411-acbb-2e23ce7cd132@posteo.de>
 <029101d76855$fa5ac300$ef104900$@gmail.com>
 <fe0a5628-e87f-6261-58c7-dbfccbb143a2@posteo.de>
 <010b01d76926$2c3c6bf0$84b543d0$@gmail.com>
From:   Patrick Menschel <menschel.p@posteo.de>
Autocrypt: addr=menschel.p@posteo.de; prefer-encrypt=mutual; keydata=
 LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptUUlOQkZ3RG1RZ0JFQUMr
 elBRRy9KTHQyWUpiNTRERFBKd0Jtd25EUTh4dUZQcEFjRjNYSVVuZkFOTGs0OUpoClhWczFR
 TnVHZk1VLytmY3RPWGd0SmF6Q3doc3NGdlUvWStPc1Nmd3FTN1ROOXhIWE1DZmtnK1gxRHhI
 ZGtqcmoKL1pUYkxHd1FUQlE2SVpVeW9BTEVSQ2RHZFBETFVqWERSS0poSTdvV3RqYlVFWUVr
 ZE9RYnY2eDhLVWd1bGtHUgpYYWxka1hJZ0R0VWZLaUE0VGhBVXpncVJuZ09DV2ZITis4TnBo
 Q2pGVlFnclRSakxCc3pkZTFnTmJkZ2kvdWxiClcyTngvS1Jqa0F1TTdFUVJvVUJ2QUJWb2FX
 R3ZYenIzUmphUFhrSk5wNHdFbm1IcVoxZlVteWMvSGZRNnVjWnkKRW5QZnlEWExtWTJQUU5P
 N2ZCemZLMTJVRTdWZHh0OTBDNURPSkRBc25kNHYreloxNHJObEpmTHNwaDZkVlNIbApsS2t2
 NE1BTndNaGxRT3Bta1pLMHhVU0Q2R0M1OHRiV0RSbEg4b3UrWUhDYlh2OHJCTXphR0phWDVB
 S25lNTJTCmZEUCtiQVVTdWVQdDhrRG5TaU1ZNk9iUEdObWhqcW1JN1RmNkU1NDdqRXUzcmxr
 aVI3Rno2cktVVzA5VlBlcnAKUnVya3orSTFtTDZ5ZTlZdGFDZ3MwbFR4b3VuYnA5emROVE04
 djZFOGJsMWNoSnRoYWs1bkEvRktnbmRtVHdhUQpNclFTRFEyNmxMcUw0MXRPZzhlVXFhTzJI
 TXVPRGNaaVVIMGVNWHlQZjhsbXhMcy9sbUVZU3hGUXFMWlBjWW9pClA0SGxVcDNSMkxIa0hO
 WDg1WDBKUldwRkkwLzNKMTFiWEpjLzc1MzVKODExdE9aRDkyRHlkK20zS3dBUkFRQUIKdENk
 UVlYUnlhV05ySUUxbGJuTmphR1ZzSUR4dFpXNXpZMmhsYkM1d1FIQnZjM1JsYnk1a1pUNkpB
 bFFFRXdFSwpBRDRXSVFUcFZLQkNXcGNoUW9QQURFY3g1bTR3ejYrNFRnVUNYQU9aQ0FJYkl3
 VUpDV1lCZ0FVTENRZ0hBZ1lWCkNna0lDd0lFRmdJREFRSWVBUUlYZ0FBS0NSQXg1bTR3ejYr
 NFRnQTJELzBTQW92U0xuK1pTcGUzK0d4UUhKMzYKWmJ1TWs0REVSa0RKMnIveStvc254WUd2
 TmNtU3N5Q1pBaVZjTTlFM0kxUXVtdDZvWHpoditJUDJNd09MZTlQMwpvUmhJQ1JyQ2RwWmY1
 YjdDb0lOc3lENUJwNGFsSUs5UFpHUDdXTjRHeGE3OVpNYkRhNVBNWGVQZ2psckFNVGNOCjRv
 c2Q5NVB4eFNkV1dheTB2TUh0VWYwRGJkaDFRNUs1U3lkREpxdG56dFBkNzBzUG9wOHBRSWhE
 NExGUWdpcFgKL3VRdkEvWnZpN2c5T3N4YThCNnRDTG41VG5LT2lNYktCVUFya1FHTDFnbDQ4
 NFJtKzRlR011YVZrVjVBb3VYMApOaGQvTVU3eEMxS2dGcWZwYTMzZ0ZRdUxTSTU2aStuRkt6
 dzNIdiszeHBJOXJjaHFXQjNnSWNVQ2lQZmFxcU1vCnI4RVNKODF0NWlvckQrRlpQb1RyMUEz
 aGZTMTNuMGxWUytsZUd3dlNucjRRZ0gvcjZ5eGw4RERIaUdFMUFXblAKaTNaWFNKWnkxRUJW
 TWJXTXFBNzFwczZDS2ZnbmpmSHVvVmNsTElXd3cxT2gwYXlER1hMZUFic1VPTGtGOXAxMwo1
 MWxRS0lJWUZpcXVwL09qa0pKMlgxaTdITjlqV2xRVnR0SER3QlhZOWNYWDRHUzk3cnNwSVhj
 S2hHRytFSVB0CjFEaFdBdDR1ZDdqcDIrSDRmTXlKZGlVK0wrYTVXNjlTODZpOURTMjBUdXd2
 K3JRemNQWTQ3MkVxZmo0elhWWmsKNUNzZ2kxVDZzQ1lnZDd5TGpHMnFYblZsSTJqQ1JyT0RW
 dGJiY25jSi9peEhPQ1h2TmlvRzZPREhBM3ZtNlZxaQpEelBmYTBFaWZveWMxbDRvSUZvQ2c3
 a0NEUVJjQTVrSUFSQUEwdUlXUGNrRlpzb0ZVZG1Sd29vMW95YzhmSyttCll6TmhTc1l0UTlI
 ZDMvQmlWeUxwUERQK0F6eks4U2JvWXVGcTJOaGRJaTIyeFRTZ2pyRFZMOU10YTdNbDB6cHgK
 QnJSTitySm5LRFl3bThJeUl6eUpCRmhXU1l3YnVPSXVqbnB6U1IvVGVDT1VvelRadFhnQmRU
 YzZrUG5kV1BWTgpDWU9hZVFXdDI1Qnc3ZGNVbllUQ1FWYm9EN0RFVWFEVkVqM1BKM2U0aGli
 TEp1UnEvK1dQY3kxQ3g2UFNucTJ6CkdQN1pVNWh6NjF2ZGovbVJJa2QxS2UzUTZmWUwzSVRN
 T1l1WGF6VUVEZ3l3TlN0bVkwRmZUT05GWEtGTXdSNm8KcUtuSGlTN2tINytxQWFodUpkdVFB
 MW9SU2xUTWRFb3F2WHEySlVJTm1NaGdYL0ZQN3ZpZEFxcTdnVjRXWElxcAptckliVHBiNVpz
 U0N6dUJBd3lkOTYxM1lmYWpZVGlUYkJGRzQ1Mld4TnlJeTFUdVpWMmIxZlhPbGdLRjNvbmUx
 CnhwbURqbTFlZVhSdjRnV0d0Vks5cXlEaUtYWnlmQ0YyL2o5d08xaTNnUHZqYmFvU1dhT2hH
 T2V6dlNFQzB4RjgKWU9TMitGSmxVclVyVm54UXZsZkdyWFYxbUpRTHpvcFJ5N0VndjNlRDI0
 NUx5YjhjUHpOUmppelRqV2RYN0g0MwpuNTlXMkdWTkFLTkNyV1pkOGNjZEdJK1RodmwzUUh1
 YWQ3NEY5cGdDUUNZWXM5dG92YVZldFR1WlI2Y3JMaG10CmxmK1V4ME5SV29PV2ZTR0w5anBt
 dkR3aGlwWCszMUlvb1FiOTZ1a2UzOFBZMUVOMjJ6QlBxZ25jVVVrUkxQQncKbEhYbnpFVit6
 U1p4QXpFQUVRRUFBWWtDUEFRWUFRb0FKaFloQk9sVW9FSmFseUZDZzhBTVJ6SG1iakRQcjdo
 TwpCUUpjQTVrSUFoc01CUWtKWmdHQUFBb0pFREhtYmpEUHI3aE9Db0lQLzNTanBFdTl4Wkpj
 TlZvU0s5MTA0enB6CmtnS2FUVmcrR0tZSEFJa1NZL3U2NU1zVmFTWk14bWVDSzdtTiswNU1w
 RUZCYW9uMG5sVTlRK0ZMRDFkRDBsenYKTVBkOEZOcEx4VEMxVDQwbXBVN0ZCV1hlVjZWRHoz
 STY5VkFBdjRWVDM4ZVZhYXBOS1lmVGdwcFRYVEVNYVdoTApVYUpGaU1HaFNYaGkrR01GV2Ji
 NVNFOGJJRTZ0WUpONWlYZUFNVFE4NjhYVGtHS0VHTjk3bEU2S09odmpWV0kxCkhiUVIzZ0tV
 ck1uVmlhbGp0YnV4bGNvS2YrblRvNG85OUEyTkprRCswaFozclJZTWhacFR1MitkcCt2Rm9p
 aEQKdVNFTCtoblZhNFRMd2pYd2gzNzNweU9XMFhra2E5YWpNTEFoMUFtMmRBa0pLSDhzMVlJ
 UUlpL2Q3bEkyYXQ1awpIcWtIa2p0YzE1ZkgrQUU5Q0VSM3RCSVNoYU9Fb0hXTXc0WEs5NS9n
 MWVnMVB1cmJmN3RwRnltcklxU3ppQjlvCjJBWituSHVDQ001ZC9pQXh5MmJOcndqNDhPM2Z5
 WXd1a0pManUyNlJKbzRMNStjNEJoTU1Ray9nVWROdldHK2YKNUxreVhvbHNMY0p0SktLdStD
 V1pFK1hxc2RGWHd2d2xDRVNSQ012cGZyQmNtY1hrT0g3S1JKVy9pUjFXVjVRZApjR3ZDcDl0
 a08vaEhSb2t0dzBibUl1MlFhZkovajZLTGJqZWV4cTc0TWUyb0U5YmkxY3B2azYvSElDV0JQ
 dHVYCnNqd2o1Q2M3UlZOMjJLekdZT0RKVGtxU0d4RjV1NVlkTHVNVG5CVGNweEphR2h3MzNq
 QjgwY3o3enFwQXBpREIKZFFnR2psVlNQT3ZidU04aXBPZDYKPW1nREMKLS0tLS1FTkQgUEdQ
 IFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=
Subject: Re: MCP2518FD Drivers Rarely Working with Custom Kernel 5.10.Y
Message-ID: <0e678105-0f24-1d73-4c99-dfea3d1731e5@posteo.de>
Date:   Thu, 24 Jun 2021 20:41:38 +0000
MIME-Version: 1.0
In-Reply-To: <010b01d76926$2c3c6bf0$84b543d0$@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


Am 24.06.21 um 20:24 schrieb Joshua Quesenberry:
> Thanks for the tips Patrick on config.txt cleanup, I'll take a closer look into that.
> 
> Not sure I'm following what you're asking for with regards to i2c. i2c1 is currently is use to communicate with accel, gyro, mag, and a power supervisor MCU that helps us accomplish wake/sleep based on accel or vehicle ignition and some other low-level hardware tasks.

Concerning i2c1 afaik it is already set up by the other two lines but I
may be wrong about that.
>> # typical combination out of raspi-config
>> dtparam=i2c_arm=on
>> dtparam=i2s=on

If you want to wake/sleep according to automotive standards, select a
CAN transceiver with a wakeup pin.

If I remember right there is even a dt overlay for on/off via pin event.

> 
> I removed the UDEV rules I had that rename can0 and can1, just in case that was causing a race condition or something else odd, but the system is behaving the same.
> 
> Not sure what else to try at this point, any ideas? What does the error number of -110 mean to you all?
...
>> [  146.964971] mcp251xfd spi0.0: SPI transfer timed out [  146.965023] 
>> spi_master spi0: failed to transfer one message from queue (ret=-110) 
>> [  146.965216] mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c (length=4, data=00 00 00 00, CRC=0x0000) retrying.
>> [  146.965247] mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c (length=4, data=00 00 00 00, CRC=0x0000) retrying.
>> [  146.965277] mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c (length=4, data=00 00 00 00, CRC=0x0000) retrying.
>> [  146.965286] mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c (length=4, data=00 00 00 00, CRC=0x0000).
>> [  146.965331] mcp251xfd spi0.0 can0: CRC read error at address 0x0000 (length=4, data=00 00 00 00, CRC=0x0000) retrying.
>> [  146.965360] mcp251xfd spi0.0 can0: CRC read error at address 0x0000 (length=4, data=00 00 00 00, CRC=0x0000) retrying.
>> [  146.965389] mcp251xfd spi0.0 can0: CRC read error at address 0x0000 (length=4, data=00 00 00 00, CRC=0x0000) retrying.
>> [  146.965397] mcp251xfd spi0.0 can0: CRC read error at address 0x0000 (length=4, data=00 00 00 00, CRC=0x0000).

110 is ETIMEOUT
according to your dmesg output, it is raised in a send context from SPI
Master and afterwards only zeros are recieved, so may be an issue with
the chip select pin. Scope it to be sure.

Regards,
Patrick
