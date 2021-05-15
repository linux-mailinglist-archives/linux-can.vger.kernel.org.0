Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C11381A6A
	for <lists+linux-can@lfdr.de>; Sat, 15 May 2021 20:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbhEOSLh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 15 May 2021 14:11:37 -0400
Received: from mout02.posteo.de ([185.67.36.66]:57699 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234189AbhEOSLg (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 15 May 2021 14:11:36 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 7DA352400E5
        for <linux-can@vger.kernel.org>; Sat, 15 May 2021 20:10:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1621102221; bh=V7E/WV9FA0yJeURIxg7Ul/BBVza0NI8uLbaHmvGkSgI=;
        h=From:To:Cc:Autocrypt:Subject:Date:From;
        b=sJAUoqgsigt4Nb83krz4KE5abYNSmm7JqqBUPgM13CiwsxFpV45fjTKply0P1vrrQ
         iKkJGMXZ/pVURJUAtbeuP7MpcGnlQsyqOrS876kY9cCuMqoEv3drGgM981u51ysHb+
         ZZunhGpjgwN7tzpLi1UYZOj1yqWrCJHO+UbVniRNKkIY+K1j86l/NTkk5SrXVksxhM
         3/h1JiqwvMBLyLfDfz9UcC8swEfdoejqq3RFAtJ5nuVkfTXHSlSBaw2iI1JC/fDqTK
         kq5YnPbWjIUmLftQYdGG2+yGwmzZpOfvnQtodZf9D5EKmJKQpLbBzbo/GvUoAE6GLe
         RnslvYhYJSQdA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FjD2j0BWSz9rxM;
        Sat, 15 May 2021 20:10:20 +0200 (CEST)
From:   Patrick Menschel <menschel.p@posteo.de>
To:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc:     linux-can <linux-can@vger.kernel.org>
References: <f0d77797-c485-2f88-57e3-b5c7b4953706@posteo.de>
 <20210515122611.GC2387@x1.vandijck-laurijssen.be>
 <38c85980-a569-b714-2643-9623b3dbc973@posteo.de>
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
Subject: Re: J1939 Questions on Intended usage
Message-ID: <72aa8b79-5ba9-26ee-3918-09532e0f1eae@posteo.de>
Date:   Sat, 15 May 2021 18:10:20 +0000
MIME-Version: 1.0
In-Reply-To: <38c85980-a569-b714-2643-9623b3dbc973@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Am 15.05.21 um 16:01 schrieb Patrick Menschel:
> Am 15.05.21 um 14:26 schrieb Kurt Van Dijck:
>> On Fri, 14 May 2021 12:04:47 +0000, Patrick Menschel wrote:
>>> Do I need to open one socket per PGN I'm sending?
>>> e.g.
>>>
>>> s1 = socket.socket(socket.AF_CAN, socket.SOCK_DGRAM, socket.CAN_J1939)
>>> s1.bind(interface_name, MY_NAME, PGN_OF_TSC1, MY_SA)
>>> s1.write(bytes(8))
>>>
>>> s2 = socket.socket(socket.AF_CAN, socket.SOCK_DGRAM, socket.CAN_J1939)
>>> s2.bind(interface_name, MY_NAME, PGN_OF_EBC1, MY_SA)
>>> s2.write(bytes(8))
>>
>> No, you don't _need_ to. You can.
>>
>> If you need quite some different PGN's, it may be more interesting to:
>> s = socket.socket(socket.AF_CAN, socket.SOCK_DGRAM, socket.CAN_J1939)
>> s.bind(interface_name, MY_NAME, ANY_PGN, MY_SA)
>> s.sendto(bytes(8), DST_1, PGN_1)
>> s.sendto(bytes(8), DST_2, PGN_2)
>> ...
>>
>> I'm not a python expert, I just assume something like that is possible.
> 
> Yes, the method exists
> 
> sendto()
> https://docs.python.org/3/library/socket.html#socket.socket.sendto
> https://github.com/python/cpython/blob/main/Modules/socketmodule.c#L4279
> 
> but apparently sockaddr_can is not yet expanded to individual parameters
> as it was done with the
> 
> bind()
> https://github.com/python/cpython/blob/main/Modules/socketmodule.c#L2207
> 
> Then I'll start by passing in the sockaddr_can struct as a first test
> and make a PR to that repo in the long run.

Guess I have to amend that impression, everything works fine,
except for broadcast which gives me a PermissionError ?!

python -i
Python 3.9.5 (default, May 13 2021, 13:29:45)
[GCC 8.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import socket
>>> s = socket.socket(socket.AF_CAN, socket.SOCK_DGRAM, socket.CAN_J1939)
>>> s.bind(("mcp0", 0, 0x40000, 0x20))
>>> s.sendto(bytes(range(8)), ("", 0, 0x12300, 0x30))
8
>>> s.sendto(bytes(range(0,0x88,0x11)), ("", 0, 0x12300, 0x30))
8
>>>

Took me some try and error to get rid of

OSError: [Errno 77] File descriptor in bad state

but at least something comes out.

candump mcp0
  mcp0  19233020   [8]  00 01 02 03 04 05 06 07
  mcp0  19233020   [8]  00 11 22 33 44 55 66 77

Maybe I didn't get the concept at all.



The transport protocol also does something.

s.sendto(bytes(range(64)), ("mcp0", 0, 0xFECA, 0x20))


TP.CM.RTS
  mcp0  18EC2020   [8]  10 40 00 0A 0A CA FE 00
TP.CM.CTS
  mcp0  18EC2020   [8]  11 0A 01 FF FF CA FE 00

TP.DT
  mcp0  18EB2020   [8]  01 00 01 02 03 04 05 06
  mcp0  18EB2020   [8]  02 07 08 09 0A 0B 0C 0D
  mcp0  18EB2020   [8]  03 0E 0F 10 11 12 13 14
  mcp0  18EB2020   [8]  04 15 16 17 18 19 1A 1B
  mcp0  18EB2020   [8]  05 1C 1D 1E 1F 20 21 22
  mcp0  18EB2020   [8]  06 23 24 25 26 27 28 29
  mcp0  18EB2020   [8]  07 2A 2B 2C 2D 2E 2F 30
  mcp0  18EB2020   [8]  08 31 32 33 34 35 36 37
  mcp0  18EB2020   [8]  09 38 39 3A 3B 3C 3D 3E
  mcp0  18EB2020   [8]  0A 3F FF FF FF FF FF FF

TP.CM.EndMsgAck
  mcp0  18EC2020   [8]  13 40 00 0A FF CA FE 00

Those with a little knowledge of J1939 will now roll on the floor ;-)


The only thing that I didn't get to work is send to broadcast.
That PermissionError is somewhat strange.

>>> s.sendto(bytes(range(8)), ("", 0, 0xFECA, 0xFF))
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
PermissionError: [Errno 13] Permission denied

>>> s.sendto(bytes(range(64)), ("mcp0", 0, 0xFECA, 0xFF))
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
PermissionError: [Errno 13] Permission denied


Best Regards,
Patrick
