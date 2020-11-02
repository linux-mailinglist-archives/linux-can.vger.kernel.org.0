Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D7F2A31A4
	for <lists+linux-can@lfdr.de>; Mon,  2 Nov 2020 18:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbgKBReP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 2 Nov 2020 12:34:15 -0500
Received: from mout02.posteo.de ([185.67.36.66]:59977 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbgKBReP (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 2 Nov 2020 12:34:15 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 913A32400FD
        for <linux-can@vger.kernel.org>; Mon,  2 Nov 2020 18:34:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1604338452; bh=fNKJPXzWazXvQWMGyG4nKnlkLOLCXngerqAdWNSA5fI=;
        h=To:Cc:From:Autocrypt:Subject:Date:From;
        b=R7W92SOvJjiPpY+57aEm7kQ9j6SpEW7L6vQ88e4sgJUKpJGk9DXPsZH0x1nzeD8q7
         FdFJjrGHAyjdOSWCjH+eDnTr6DouPOighk5MEJJsWeY1uRgnCx3WARc0zUnvgAaNto
         hZnSrkGEpeQtkDF5Ob/qJecZQFbtXm8gCQoMvSNU3TfPvVVTpZKaf3XzOJsYc6D+L0
         thhytDH1dD5MAvWAykZinFG/PVueaVmVCghnPV9Jj6sTjhihhEZNBL4pxrbsrVat3H
         K4M67t5IV3orvrGMvoWLpqSd2FW6fPaAPnymeEFG3Hc/+5fE9grfcXcCzGLFH8OHv2
         PydHePci5yjBw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4CQ0QW1dJ6z6tmP;
        Mon,  2 Nov 2020 18:34:11 +0100 (CET)
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Drew Fustini <drew@beagleboard.org>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, Josh S <josh@macchina.cc>
References: <CAPgEAj5eeN7Q9Hs7ZcrvaNCQJ7uW8kyNs3CPiVfQ=AEX9WeYoQ@mail.gmail.com>
 <CAPgEAj6z_DaycgVOqvqqTv2KVRcascT8_nd+FNnZJtg0ObGPaw@mail.gmail.com>
 <CAPgEAj6nu475YeeWXc3wWO8sAmn8stz2Qr3nQ=HABd8CKR-c+w@mail.gmail.com>
 <41b606d5-5991-4d4f-bd6f-aaaf31cbc9b5@pengutronix.de>
 <6a7061a4-771d-6703-1e30-273050abfb9d@posteo.de>
 <2593d8e0-2d42-0461-e2e1-86a71b415476@pengutronix.de>
 <CAPgEAj5JheUirqr2kLrjJpwCaK3+HZyo8r8uKk25zMREVXWT3Q@mail.gmail.com>
 <CAPgEAj4W61tCSkdrCP2J4dL7WwQ1NKzFCUGjY9o4_qj+NG5KEA@mail.gmail.com>
 <3d19330b-860b-7d76-bc6d-768a7b00ed4b@pengutronix.de>
 <CAPgEAj6qZxfsyuarVgvnXkHd3ZUAP-3fgD-nONCcn-C5xY44+Q@mail.gmail.com>
 <e955f39f-2417-4dca-ee3c-70b328c1014d@posteo.de>
 <3a5f81d6-13ba-71b8-67a7-fe6e8a13f84a@posteo.de>
 <CAPgEAj7B5O5nwqr-nMBXNqgx9tD5=9XPG0W0=C21FMD6S+bR-A@mail.gmail.com>
 <3b7b6353-0493-210a-7c14-e7ccc1067365@pengutronix.de>
 <CAPgEAj7LcX3cb+syhtR1i3Uo1XkYYFQ_wDPV8GniaA-YwPk2Hg@mail.gmail.com>
 <08a1fb36-5efb-27d8-f5b9-bd2a923479a2@pengutronix.de>
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
Subject: Re: mcp251xfd on RPi 5.4 downstream
Message-ID: <9e9db79d-9357-19bd-0584-3f97ed49c731@posteo.de>
Date:   Mon, 2 Nov 2020 18:34:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <08a1fb36-5efb-27d8-f5b9-bd2a923479a2@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

>     https://www.waveshare.com/w/upload/e/e2/2-CH-CAN-FD-HAT-Schematic.pdf
> 
> Grmpf :/
> 
>> This means that can1 cs is connected to pi header pin 26 
> 
> Both of rpi's SPI host drivers prefer to use GPIO chip selects by default, as
> native chip selects have some limitations. And all three mcp251xfd overlays use
> GPIO chip selects, this means you can use any free GPIO in the system for the
> SPI chip select.
> 
> Marc
> 

It took me a while to realize but those pin numbers on the PCB are
WPI := WiringPi numbers, not header pin numbers and not BCM pin numbers.

The schematics also has the WPI column in the lower left section.

https://pinout.xyz/pinout/wiringpi#

--
Patrick
