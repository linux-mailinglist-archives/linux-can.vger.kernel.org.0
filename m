Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD2B36A670
	for <lists+linux-can@lfdr.de>; Sun, 25 Apr 2021 12:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhDYKLz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Apr 2021 06:11:55 -0400
Received: from mout01.posteo.de ([185.67.36.65]:42665 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229551AbhDYKLy (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sun, 25 Apr 2021 06:11:54 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 6CA40240026
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 12:11:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1619345472; bh=F9u1iTLwOt91V7mBbTjLBoz8agPwKE0L92eAGar5CeY=;
        h=To:From:Autocrypt:Subject:Date:From;
        b=TN6dH1/WX/odvYhw81AYWv7/58g3EaJvDKXV3cSw4uscnwpXSbAMUGh+i3xwIOpsY
         JgYa0j0APP7wYdma1UcnClffGBkBZdhM10+GuzTnDVjlzifiknaHVWjh9WFNj/yemQ
         CVrh8E2togYEb9+j+DGMqDg5tLU5ggxD/aXLxHJ0qFixbbUY2L+bxscy1O97yobFmv
         J+CxxBbVEJ5Ox9h3QWvwZISf8PbxrQ+PPSIu+opqeP6Q9eqoldFVVsomAKRvxrEpST
         R/Boud66Q57VcSONUn8qZi4hCTTLUPL/vevMlKYW3rfS88czY9ISsdQvuFn3gZrjXb
         Ep1/CPZzBdoCw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FSkM40b0mz9rxL
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 12:11:12 +0200 (CEST)
To:     linux-can <linux-can@vger.kernel.org>
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
Subject: can-isotp: isotp_tx_timer_handler: can_send_ret -105
Message-ID: <97b76750-3416-decf-82a8-8039c8146482@posteo.de>
Date:   Sun, 25 Apr 2021 10:11:11 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

I'm experiencing a socket timeout when receiving an isotp transfer of
256 + overhead bytes via a real can interface. The same application runs
without problems on vcan0.

The output of dmesg.

[  146.507796] can: isotp protocol
[  146.534527] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[  146.534672] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[  146.534794] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[  146.534920] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[  146.535044] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[  146.535169] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[  146.535294] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[  146.535418] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[  146.535543] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[  146.535668] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[  194.034609] can-isotp: isotp_tx_timer_handler: can_send_ret -105


The output of candump.
  mcp0  17FC05F4   [8]  11 07 3C 00 00 00 00 00
  mcp0  17FE05F4   [3]  30 00 00
  mcp0  17FC05F4   [8]  21 00 42 4F 4F 54 00 00
  mcp0  17FC05F4   [8]  22 00 00 00 5E 02 00 6A
  mcp0  17FC05F4   [8]  23 00 65 90 C4 BB FC 6C
  mcp0  17FC05F4   [8]  24 7A 68 F2 A2 C0 33 1F
  mcp0  17FC05F4   [8]  25 C8 D5 A7 E1 7C 00 01
  mcp0  17FC05F4   [8]  26 43 20 01 00 00 00 00
  mcp0  17FC05F4   [8]  27 00 00 00 00 00 00 00
  mcp0  17FC05F4   [8]  28 00 00 00 00 00 00 00
  mcp0  17FC05F4   [8]  29 00 00 00 00 00 00 00
  mcp0  17FC05F4   [8]  2A 00 00 15 00 00 00 10
  mcp0  17FC05F4   [8]  2B 00 00 00 02 00 00 00
  mcp0  17FC05F4   [8]  2C D4 57 45 20 E8 57 45
  mcp0  17FC05F4   [8]  2D 20 14 58 45 20 1C 58
  mcp0  17FC05F4   [8]  2E 45 20 24 58 45 20 2C


The setup is a pi0w with the seeed can fd board, e.g. mcp2518fd and
current standard Raspbian. I'm running a (file) server on mcp0, a mock
client on mcp1 and both are directly connected.
The communication is technically full duplex with two independent isotp
channels but the other channel is silent until a transfer is complete.

Is such an issue known ?
May this happen due to the limited resources of a pi0w ?

Best Regards,
Patrick Menschel
