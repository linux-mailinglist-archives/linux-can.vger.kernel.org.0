Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E5A1F78EF
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2020 15:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgFLNr5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 12 Jun 2020 09:47:57 -0400
Received: from mout02.posteo.de ([185.67.36.66]:33173 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgFLNr4 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 12 Jun 2020 09:47:56 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 16FA3240100
        for <linux-can@vger.kernel.org>; Fri, 12 Jun 2020 15:47:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1591969673; bh=B2G2A1p7w98wYGxouwseZUaAmMWP9qWoJ/44GLLY60g=;
        h=To:Cc:From:Autocrypt:Subject:Date:From;
        b=nGaIPBTTpVoKLzM84fSPBHKh3CK6DT88G1MNVY4erhJE+rlmCX8QTyqqlByqW0+oM
         utpqZFS9ORLCkMhSubCPvBApC3TI7ffKZR3EtmLkZwZKLb6NdGILS1w6Ilvm/demr2
         a16+21zwKdcoGkvfPhLfZx2KN2gFU8+vr6kDThvo+zbtbyBLEJ+b5TIizJLilvmDP9
         PaFzKSvt1nN0KWQ/UHgvPL9mbm2LpA0cObrcufQhms/SPMlDHnMtgjhFivzrLmcILR
         Lt2a7pVd+8A2nF7eUyqMJqLAkdYEhorkn8RuwO209xyzPkF94D+on4xRFBRUxH3zqs
         s/CjCrd/uOvdA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 49k29M4r62z9ry4;
        Fri, 12 Jun 2020 15:47:51 +0200 (CEST)
To:     Drew Fustini <drew@beagleboard.org>
Cc:     linux-can@vger.kernel.org
References: <20200611154337.GA3166627@x1>
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
Subject: Re: isotp in mainline?
Message-ID: <9d3bcfde-68f3-c9e0-4c63-cbae61915585@posteo.de>
Date:   Fri, 12 Jun 2020 15:47:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611154337.GA3166627@x1>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="EOC9GjY70WzpR9VoI4RJZrMj0GgCQgjhk"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EOC9GjY70WzpR9VoI4RJZrMj0GgCQgjhk
Content-Type: multipart/mixed; boundary="A8bmtt9iFbuk79r6vFXIPuZXuMp2lQsdP";
 protected-headers="v1"
From: Patrick Menschel <menschel.p@posteo.de>
To: Drew Fustini <drew@beagleboard.org>
Cc: linux-can@vger.kernel.org
Message-ID: <9d3bcfde-68f3-c9e0-4c63-cbae61915585@posteo.de>
Subject: Re: isotp in mainline?
References: <20200611154337.GA3166627@x1>
In-Reply-To: <20200611154337.GA3166627@x1>

--A8bmtt9iFbuk79r6vFXIPuZXuMp2lQsdP
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hi Drew,

> Is there a current effort to get the isotp driver accepted into mainlin=
e?

I believe ISOTP has been mainline for quite a while.

I remember writing a test script when Python 3.7 came out in Aug 2018
and added the isotp socket type to socket class [1].

I tested on a X86_64 machine with Ubuntu 18.04 LTS, so it must have been
mainline at that time.

Regards,
Patrick

[1]
https://docs.python.org/3.7/library/socket.html?highlight=3Dsocket#socket=
=2ECAN_ISOTP


--A8bmtt9iFbuk79r6vFXIPuZXuMp2lQsdP--

--EOC9GjY70WzpR9VoI4RJZrMj0GgCQgjhk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6VSgQlqXIUKDwAxHMeZuMM+vuE4FAl7jh4YACgkQMeZuMM+v
uE4jsBAAnMEu5vaGa9zauO22UgCZ8+/snYhXiP5ERNb3h6isNfmmtyUBhufF5JU/
JuX7206o4ysAIoFvgvplwVq7s+nUBMR0X9xmlBY/ubhUwq757jT4apmWHdN2deVJ
qRy0pdU3SFUmyTAplGmyRdYPSDo5Cd6xPhMhw7QeMIZtaDq669Vrcf/hLkd5qEr7
+oAz3W4LpH9SdnNGR2rr0gT6kR2qOOiqa0FEK51zU0aYgb591ZKDO8GROaq93beL
+QABJ4lec5sm9rhwq8210++9tErkBkBtBtscBrVC30vo3JhKQOQMMT+t/5i0fkoa
aGkRnNLgraUU4/5e15OZX9OrMe5LpiV9UdRiv71WLV5eMsaidgFOlaiuecz4ewbv
kkbpq9WM/R0y/H9EF/Xr/pebgjzCSMeZo8TavlvK+F3HJkltKzMWOp04TcJLpLje
wtc7BRr6T49U8gCMGAUY80tAd0knWBlZcg6mq126UnMeXAirq/KKDISfWI/zVkmg
yx8CCi9Z2RLC/OkCwmUg7eDED2w+iLFvbAHmGKgjQuIVdRPfTUbKh2QZ2mYxecMY
pknpWjXliPi+nOccO+o6GtLlzgxA/XhdcynlhffdwSv5jv7mN3hYUXpqlOnuLDiB
2IEWG5nMNiZqKCoZZZ4jkwVWFva50To337n07Jrhxfh8epuRph4=
=x42e
-----END PGP SIGNATURE-----

--EOC9GjY70WzpR9VoI4RJZrMj0GgCQgjhk--
