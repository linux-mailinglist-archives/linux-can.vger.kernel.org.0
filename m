Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A34D376190
	for <lists+linux-can@lfdr.de>; Fri,  7 May 2021 09:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbhEGIA2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 7 May 2021 04:00:28 -0400
Received: from mout02.posteo.de ([185.67.36.66]:45217 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233730AbhEGIA1 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 7 May 2021 04:00:27 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 37D212400FD
        for <linux-can@vger.kernel.org>; Fri,  7 May 2021 09:59:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1620374365; bh=XHrJOzuCSj1w1wLx7ng+DmZ22HCLue6kOt+K4FhZsBE=;
        h=To:Cc:From:Autocrypt:Subject:Date:From;
        b=YyozvbKHYdnReqYq3jgiFjwgR6wl6koMfE/odmC8d4dvelKEfxxo9OpjlD1oE7C6Z
         Pm/ar0xuTwc9+TofWXCTQlBv3yhlI/jjOpkfrSWB7dMDo5ZsXaGPzHKR5m/H5To/5d
         DpHqFJE4hJ8UCadg+tUstzFDLZI3CC/w9wwVbdcDOqdYc0QZ3n5NA1hMqyQPK5EJPz
         2NNEoaMDnEmkpup8uI+7HmWY6P7I2DewqwycgqHNWSZAtLWfjiOGKa2sZz4FHLAGTi
         RZGMLzHgfRaEASylNP3g9FxM4CI5XnQQaQS9AvClUlE8ywT5kvI3Rz/LAQvWqizxES
         P5ZN3lpEzuTFA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Fc2sS5ZFvz6tmD;
        Fri,  7 May 2021 09:59:24 +0200 (CEST)
To:     Bartosz Zdanowicz <zdanowiczb@gmail.com>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can <linux-can@vger.kernel.org>
References: <CAERdor5nY73X4qip=up8fNU=xT+H7r2XnKiob66=4DxovkBiGw@mail.gmail.com>
 <a7df697c-b6d3-1894-dcc6-672698caa19a@hartkopp.net>
 <CAERdor5o6yKq1J-hBbjiBtU63OkxhijKifO0OEBt21ASKhCXuw@mail.gmail.com>
 <02607798-4701-376a-6a58-2ff29c87ccab@posteo.de>
 <CAERdor7LiPPJWLxMQdrQsF=jU0yHNU_uwLAbQegpUj4KeJHzgg@mail.gmail.com>
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
Subject: Re: CAN ISO-TP
Message-ID: <587ef081-804b-9816-f899-f4bd645865cf@posteo.de>
Date:   Fri,  7 May 2021 07:59:24 +0000
MIME-Version: 1.0
In-Reply-To: <CAERdor7LiPPJWLxMQdrQsF=jU0yHNU_uwLAbQegpUj4KeJHzgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Am 07.05.21 um 09:24 schrieb Bartosz Zdanowicz:
> pt., 7 maj 2021 o 09:02 Patrick Menschel <menschel.p@posteo.de> napisał(a):
>>
>> Am 06.05.21 um 23:28 schrieb Bartosz Zdanowicz:
>>>> Can you create a candump log from vcan0 to see, what's going on the bus?
>>>>
>>> On RPI after first send I got
>>> pi@raspberrypi:~ $ candump can0
>>>   can0  002   [8]  10 09 41 41 41 41 41 41
>>>
>>> After the second message I got mentioned OSError and there is no data
>>> on candump. Sending again I received next frame:
>>> pi@raspberrypi:~ $ candump can0
>>>   can0  002   [8]  10 09 41 41 41 41 41 41
>>>   can0  002   [8]  10 09 41 41 41 41 41 41
>>>
>>> On my local PC where I get no system Error I got one frame per every send:
>>>  bartosz  ~/Work/DeltaThermal/can-isotp   master  candump vcan0
>>>   vcan0  002   [8]  10 09 41 41 41 41 41 41
>>>   vcan0  002   [8]  10 09 41 41 41 41 41 41
>>>   vcan0  002   [8]  10 09 41 41 41 41 41 41
>>>   vcan0  002   [8]  10 09 41 41 41 41 41 41
>>>   vcan0  002   [8]  10 09 41 41 41 41 41 41
>>>   vcan0  002   [8]  10 09 41 41 41 41 41 41
>>>>
>>>> ...
>>>> So how is Python getting this information?
>>>>
>>> In general, that's the biggest issue for me. Because in my real
>>> application I'm using python select() and recv() on that socket. When
>>> this error is raised, my select() on socket deduce something is
>>> received and recv() function also throws an error. I just tried to get
>>> a minimal example that reproduces the issue which is above. In those
>>> cases I would expect timeout, not OSError.
>>
>>
>> As expected, timeout error on missing flow control. Since it's tx side
>> it just tells -ECOMM instead of -ETIMEDOUT .
>>
>> https://github.com/raspberrypi/linux/blob/rpi-5.10.y/net/can/isotp.c#L10
>> https://github.com/raspberrypi/linux/blob/rpi-5.10.y/net/can/isotp.c#L755
>>
>> Is there a specific reason why you use select.select() instead of
>> Socket.recv(timeout) / Socket.send() ?
>>
>> Best Regards,
>> Patrick
> 
> I have a seperate thread that waits and process data, since I have
> multiple sockets opened I want to wait for any of them:
> 
> while True:
>     ready_sockets = select.select(self.sockets, [], [], self.timeout)[0]
>         if not ready_sockets:
>         logging.info("No data received")
>         continue
>     for socket in ready_sockets:
>         self.process_data(socket=socket)
> 
> In process_data I call:
> 
> received = socket.recv()
>     if received:
>     #process data
> 
> My main thread is sending data on those sockets:
> schedule.every(X).seconds.do(request_that_sends_using_socket.send(),
> socket=socket)
> 
> So the flow is that my thread sends data to another device, and the
> processing thread is waiting for data. When I don't send any data I
> get only prints "No data received" which is expected cause no device
> is responding (no device is running). When I send data (no other
> device is running) I get an error on send AND my select() is finished
> with an error socket inserted to ready_sockets. That means I enter
> self.process_data() function with socket and also recv() fails. So it
> seems it's not only that OSError is raised but also that socket is
> somehow "invalid" because it triggers select() which should not be
> triggered (no data was received).


Ok,

try to enable CAN_ISOTP_WAIT_TX_DONE via socket.setsockopt() .
https://github.com/raspberrypi/linux/blob/rpi-5.10.y/net/can/isotp.c#L14

https://gitlab.com/Menschel/socketcan/-/blob/master/socketcan/socketcan.py#L583

and wrap tx into a try-except block.

try:
    self.process_data(socket=socket)
except OSError as e:
    print(e)

With this you actually have a chance to do error handling on tx path
instead of hitting an already present error of the previous op.

Regards,
Patrick

