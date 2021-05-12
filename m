Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AEC37EE49
	for <lists+linux-can@lfdr.de>; Thu, 13 May 2021 00:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239705AbhELV1d (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 12 May 2021 17:27:33 -0400
Received: from mout02.posteo.de ([185.67.36.66]:51987 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378481AbhELTRA (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 12 May 2021 15:17:00 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 3DD9E2400FD
        for <linux-can@vger.kernel.org>; Wed, 12 May 2021 21:15:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1620846948; bh=Qg5JoXsBqFhi0FEgCnXY8CicyQvQ7L0dYhoAXSyx1wU=;
        h=From:To:Cc:Autocrypt:Subject:Date:From;
        b=Cl/d1vM4KcHXxFyOuOUvDh4dTomzmsvScbT/tSrJHpbEdvVBeBF808fBoGlG8UhYr
         Bgjtm0JGeIqadPJE/eU74oN2WC2jp6SY2BK6qN6mNrr0osVZGUTLENBVxZpNn9yJ0v
         nHaDk77nrpBKlCE/tjUExeABUqvRzkQpsuDHgo1220ZwEzC1OLVgFrWrNfZ/RF8N9t
         fzqLpEcqShXO1TfxD+sChZDC9PcMsA/9VDwYWYyeC6bOBXB4HnoxFmlZJ4b57yh95T
         ygbc3AS4Jv3MP0YZfqDpkYl5AYHNNXnKAos75Sp3Kk25YsrEtG9ugkYuIRDUGz0YKb
         ew5tD0R8mhe0Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FgPdb3wk5z6tmD;
        Wed, 12 May 2021 21:15:47 +0200 (CEST)
From:   Patrick Menschel <menschel.p@posteo.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Bartosz Zdanowicz <zdanowiczb@gmail.com>
Cc:     linux-can <linux-can@vger.kernel.org>
References: <CAERdor5nY73X4qip=up8fNU=xT+H7r2XnKiob66=4DxovkBiGw@mail.gmail.com>
 <a7df697c-b6d3-1894-dcc6-672698caa19a@hartkopp.net>
 <CAERdor5o6yKq1J-hBbjiBtU63OkxhijKifO0OEBt21ASKhCXuw@mail.gmail.com>
 <02607798-4701-376a-6a58-2ff29c87ccab@posteo.de>
 <CAERdor7LiPPJWLxMQdrQsF=jU0yHNU_uwLAbQegpUj4KeJHzgg@mail.gmail.com>
 <587ef081-804b-9816-f899-f4bd645865cf@posteo.de>
 <CAERdor4VkyxQ3X4gZn1jR9PFkwg2BqbC+iG9DQXECakdpsotkA@mail.gmail.com>
 <7ad89748-c309-1153-aa8f-b0e98160e39d@posteo.de>
 <43d77f58-1ec9-302c-d8f0-654444046cab@posteo.de>
 <90c29725-5d6d-e4b9-6e28-a002a8f0bfcf@hartkopp.net>
 <fcb494bd-8871-587c-b097-578f0760d05c@posteo.de>
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
Message-ID: <93235f8d-d727-41a4-a9ee-09391f2a10e1@posteo.de>
Date:   Wed, 12 May 2021 19:15:47 +0000
MIME-Version: 1.0
In-Reply-To: <fcb494bd-8871-587c-b097-578f0760d05c@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Am 11.05.21 um 21:02 schrieb Patrick Menschel:
> Am 11.05.21 um 19:44 schrieb Oliver Hartkopp:
>> On 11.05.21 18:37, Patrick Menschel wrote:
>>> Am 10.05.21 um 20:04 schrieb Patrick Menschel:
>>>> Am 10.05.21 um 12:02 schrieb Bartosz Zdanowicz:
>>>>> pt., 7 maj 2021 o 09:59 Patrick Menschel <menschel.p@posteo.de>
>>>>> napisał(a):
>>>>>> try to enable CAN_ISOTP_WAIT_TX_DONE via socket.setsockopt() .
>>>>>> https://github.com/raspberrypi/linux/blob/rpi-5.10.y/net/can/isotp.c#L14
>>>>>>
>>>>>>
>>>>>> https://gitlab.com/Menschel/socketcan/-/blob/master/socketcan/socketcan.py#L583
>>>>>>
>>>>>>
>>>>>> and wrap tx into a try-except block.
>>>>>>
>>>>>> try:
>>>>>>      self.process_data(socket=socket)
>>>>>> except OSError as e:
>>>>>>      print(e)
>>>>>>
>>>>>> With this you actually have a chance to do error handling on tx path
>>>>>> instead of hitting an already present error of the previous op.
>>>>>>
>>>>> I used following code:
>>>>>
>>>>> import isotp
>>>>> import time
>>>>> s = isotp.socket()
>>>>> s._socket.settimeout(2)
>>>>> s.set_opts(s.flags.WAIT_TX_DONE)
>>>>> s.bind("can0", isotp.Address(rxid=1, txid=2))
>>>>>
>>>>> s.send(b"aaaaaaaaa") -> returns immediately with number of bytes
>>>>> s.send(b"aaaaaaaaa") -> same OS error as above (Error 70)
>>>>>
>>>>
>>>> OK,
>>>>
>>>> this is really strange. I have no clue how that is possible unless it's
>>>> on kernel side.
>>>>
>>>> I have to write a test for it later.
>>>
>>> I can confirm this behaviour, it is definetly kernel-side of the socket.
>>>
>>> tests/test_socketcan.py::TestCanIsoTpSocket::test_should_fail_missing_flow_control_on_transfer
>>>
>>>
>>> --------------------------------------------------------------------------------------------------
>>>
>>> live log call
>>> --------------------------------------------------------------------------------------------------
>>>
>>> 2021-05-11 18:14:00 [    INFO] Return value of IsoTpSend without flow
>>> control: 64 (test_socketcan.py:720)
>>> 2021-05-11 18:14:01 [   ERROR] Return value of IsoTpSend without flow
>>> control: None, Raised [Errno 70] Communication error on send
>>> (test_socketcan.py:718)
>>>
>>> Apparently there is another message thread for this and something was
>>> fixed.
>>>
>>> https://marc.info/?i=97e2ddd5-cc8b-9c7b-6198-2eceee39dfd4%20()%20hartkopp%20!%20net
>>>
>>>
>>> Funny thing is, it does not care about the wait_tx_done flag, this
>>> happens with and without it.
>>
>> The error handling was originally intended to be done by simple timeout
>> monitoring on application level.
>>
>> What I assume from the output above:
>>
>> 1st attempt: We have a failure but we happily return that we have send
>> 64 bytes (which Marc improved with the above referenced patch for
>> CAN_ISOTP_WAIT_TX_DONE mode).
>>
>> (socket remains open?!?)
>>
>> 2nd attempt: The error from the first attempt shows up in the socket
>> error message queue?!?
>>
>> I just did some tests with a modified isotpsend.c which closes the
>> socket after the sending operation. This is probably the reason I did
>> not see that behaviour ...
> 
> I forgot to post my test which produced that result above.
> 
> https://gitlab.com/Menschel/socketcan/-/commit/bd7bfebde1d791c7dccb717c849398c0d0f53dcd
> 
> I run it on a pi0w with regular raspbian buster and a recent python
> 3.9.4 installed.
> "pytest
> tests/test_socketcan.py::TestCanIsoTpSocket::test_should_fail_missing_flow_control_on_transfer"


Just tying some loose ends here.
I rewrote the test to be in line with pytest convention.
"can_interface" is a pytest fixture which will use any CAN interface
that is available. OSError is expected so it fails.

Regards,
Patrick

https://gitlab.com/Menschel/socketcan/-/blob/master/tests/test_socketcan.py#L708

====================================================================================================
FAILURES
=====================================================================================================
______________________________________________________________________
TestCanIsoTpSocket.test_should_fail_missing_flow_control_on_transfer
_______________________________________________________________________

self = <tests.test_socketcan.TestCanIsoTpSocket object at 0xb55d2370>,
can_interface = 'mcp1'

    def test_should_fail_missing_flow_control_on_transfer(self,
can_interface):
        rx_addr = 0x18DA01FA
        tx_addr = 0x18DAFA01
        s = CanIsoTpSocket(interface=can_interface, rx_addr=rx_addr,
tx_addr=tx_addr)
        data = bytes(range(64))
        with pytest.raises(OSError):
>           err = s.send(data)
E           Failed: DID NOT RAISE <class 'OSError'>

tests/test_socketcan.py:714: Failed
________________________________________________________________
TestCanIsoTpSocket.test_should_fail_missing_flow_control_on_transfer_and_wait_tx
_________________________________________________________________

self = <tests.test_socketcan.TestCanIsoTpSocket object at 0xb55d28b0>,
can_interface = 'mcp1'

    def
test_should_fail_missing_flow_control_on_transfer_and_wait_tx(self,
can_interface):
        rx_addr = 0x18DA01FA
        tx_addr = 0x18DAFA01
        s = CanIsoTpSocket(interface=can_interface, rx_addr=rx_addr,
tx_addr=tx_addr, wait_tx_done=True)
        data = bytes(range(64))
        with pytest.raises(OSError):
>           err = s.send(data)
E           Failed: DID NOT RAISE <class 'OSError'>

tests/test_socketcan.py:722: Failed

