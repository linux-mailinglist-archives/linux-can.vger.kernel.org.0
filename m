Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE8B2E1C92
	for <lists+linux-can@lfdr.de>; Wed, 23 Dec 2020 14:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgLWNaw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Dec 2020 08:30:52 -0500
Received: from mout02.posteo.de ([185.67.36.66]:53579 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728581AbgLWNav (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 23 Dec 2020 08:30:51 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 07E692400FF
        for <linux-can@vger.kernel.org>; Wed, 23 Dec 2020 14:29:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1608730193; bh=bfPLh2dDIkhXTlzTZ0DH3WigQp5Kme+WpHMm/eZn2JA=;
        h=From:To:Cc:Autocrypt:Subject:Date:From;
        b=OUng00joOPe9rTU+6cyib/RUJjnKLKNqCsqBTPeX+PWKuKmU0fWsaewLSMLJKKcMj
         2HsZPQmHbtfGVB7vu7/K7thlg8K+5N1vfiYAGxjbs1GNWAC1ElzVX9hjfrvyfgrQQt
         st9J+mHilM2RCQ5BK3HlIPrusb+Si63u/wCUr4QkKxR+0buIiLk+Ip948l3Xnn6w6G
         5MMCvwUeUOThah3EqZr9Pwwy60mFDxjWk/M27Esv29JjyOvVHHuyOda+cXbQtscV8l
         fi8UT/1157hVgG6Wj/Crimm9ybaDHZPWGZwMBysoU3Ju6Zbj0+SngG60zgZeln6kpp
         G3sBA9CYubQRw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4D1Db42Nfmz6tmV;
        Wed, 23 Dec 2020 14:29:52 +0100 (CET)
From:   Patrick Menschel <menschel.p@posteo.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Sven Schuchmann <schuchmann@schleissheimer.de>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <DB8P190MB06343276BF64CB3530DEB5D6D9C50@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <32e1f29b-b16e-bc8e-e57a-92c67d45a335@pengutronix.de>
 <DB8P190MB0634B8626AEF0F14A653DC67D9C50@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <f9538bbb-89a8-86b0-8e34-31150caee140@pengutronix.de>
 <DB8P190MB063448143C2C8F7FE8457CFAD9C50@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <a348a235-35e1-c098-ce26-19e5cca7856f@posteo.de>
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
Subject: Re: assignment of spi to can channels
Message-ID: <3a7db585-9fd1-ea11-a063-549c5a086473@posteo.de>
Date:   Wed, 23 Dec 2020 14:29:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a348a235-35e1-c098-ce26-19e5cca7856f@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Bumping on this topic again. A

https://www.seeedstudio.com/CAN-BUS-FD-HAT-for-Raspberry-Pi-p-4742.html

arrived at my place today. I updated the rpi-0w-1 to latest official
packages and it turns out, everything found its way into release and
seems to be working fine.

There is one thing bugging me though, it runs on different SPIs then
Sven's board. My setup is

dtoverlay=mcp251xfd,spi0-0,interrupt=25
dtoverlay=mcp251xfd,spi0-1,interrupt=24

SUBSYSTEM=="net", ACTION=="add",
DEVPATH=="/devices/platform/soc/*/*/*/spi0.0/net/can?", NAME="mcp0"
SUBSYSTEM=="net", ACTION=="add",
DEVPATH=="/devices/platform/soc/*/*/*/spi0.1/net/can?", NAME="mcp1"


pi@rpi-0w-1:~ $ dmesg | grep -Ei can\|spi
[   30.107770] CAN device driver interface
[   30.280715] spi_master spi0: will run message pump with realtime priority
[   30.316946] mcp251xfd spi0.1 can0: MCP2518FD rev0.0 (-RX_INT
-MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz
r:17.00MHz e:0.00MHz) successfully initialized.
[   30.379053] mcp251xfd spi0.0 can1: MCP2518FD rev0.0 (-RX_INT
-MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz
r:17.00MHz e:0.00MHz) successfully initialized.
[   30.528401] mcp251xfd spi0.0 mcp0: renamed from can1
[   30.613025] mcp251xfd spi0.1 mcp1: renamed from can0


As it happens it runs on a rpi zero w . Is there some sort of stress
test I could run to see the platform limits?

--
Patrick


>>> -----Ursprüngliche Nachricht-----
>>> Von: Marc Kleine-Budde <mkl@pengutronix.de>
>>> Gesendet: Mittwoch, 16. Dezember 2020 21:27
>>>> created /etc/udev/rules.d/70-can.rules with
>>>> SUBSYSTEM=="net", ACTION=="add", DEVPATH=="/devices/platform/soc/*/*/*/spi0.0/net/can?", NAME="can0"
>>>> SUBSYSTEM=="net", ACTION=="add", DEVPATH=="/devices/platform/soc/*/*/*/spi1.0/net/can?", NAME="can1"
>>>
>>> Note: IFAIK this will not work with newer versions of udev....
>>>
>>>> and tadaaaaa:
>>>> [    6.917578] spi_master spi1: will run message pump with realtime priority
>>>> [    6.936957] mcp251xfd spi1.0 can0: MCP2518FD rev0.0 (-RX_...
>>>> [    6.956523] spi_master spi0: will run message pump with realtime priority
>>>> [    6.971942] mcp251xfd spi0.0 can1: MCP2518FD rev0.0 (-RX_...
>>>> [    7.006515] mcp251xfd spi1.0 rename3: renamed from can0
>>>> [    7.041681] mcp251xfd spi0.0 can0: renamed from can1
>>>> [    7.091563] mcp251xfd spi1.0 can1: renamed from rename3
>>>
>>> ...the "rename" trick doesn't work anymore. Better use a differnet name, e.g.:
>>> mcp0 and mcp1.
>>
>> okay, understood and renamed:
>> [    6.673732] mcp251xfd spi0.0 mcp0: renamed from can0
>> [    6.716051] mcp251xfd spi1.0 mcp1: renamed from can1
>>
>> Thanks!
>>
>>    Sven
>>
