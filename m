Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DD5601805
	for <lists+linux-can@lfdr.de>; Mon, 17 Oct 2022 21:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJQTs0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Oct 2022 15:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiJQTsZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Oct 2022 15:48:25 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADAD726B3
        for <linux-can@vger.kernel.org>; Mon, 17 Oct 2022 12:48:23 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id D9346240028
        for <linux-can@vger.kernel.org>; Mon, 17 Oct 2022 21:48:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1666036101; bh=kQqas/l4RGylt5OYCC0766+1m+e0IDaLX3OhfJRn6r8=;
        h=Date:To:From:Subject:From;
        b=hUipzAWx1pBk0vNtkJgutpFd/S1VISj25uK5ODbOoeNDp/QAVdZPCNrS2eESQQLw1
         IO7V3OjrARWlCDSx0LciJUCQ1wjXDnOM5XX9RmCnS4Ohq9mTsLrNOUVGZY4RFGsndZ
         O3VUpazSZi8H4sJEmcqvwCykzkW3Cj0vg5cxVwU6U1LH+3aLCHzU/36/b4dSlPwIik
         oeHpmOv9tIXGcEdbE5JiTpadLT47zUJT+tWlBCapJOFhcrwYuuqRPvJoNzApEb1iYa
         gMq4kUzb1QbeCwWTwRtTz29aTG/NsMFv4l62cZi7/DI7/GNa5yk/ADVaJqlwaLD+0V
         A9WcEYUD35T2Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Mrnbn0rqgz9rxR;
        Mon, 17 Oct 2022 21:48:21 +0200 (CEST)
Message-ID: <d822d70a-717a-e2b6-06a4-d6e276615bc1@posteo.de>
Date:   Mon, 17 Oct 2022 19:48:20 +0000
MIME-Version: 1.0
To:     Sebastien FABRE <sebastien.fabre@actia.fr>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <PR0P264MB23096FC238E648331A32B5A492299@PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM>
Content-Language: de-DE
From:   Patrick Menschel <menschel.p@posteo.de>
Subject: Re: J1939: Send messages without acknowledging
In-Reply-To: <PR0P264MB23096FC238E648331A32B5A492299@PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------SCeewv7y3X85e6x3j60W30MS"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------SCeewv7y3X85e6x3j60W30MS
Content-Type: multipart/mixed; boundary="------------PX9h9hCCaMGv4Pa4vJ9tUEZM";
 protected-headers="v1"
From: Patrick Menschel <menschel.p@posteo.de>
To: Sebastien FABRE <sebastien.fabre@actia.fr>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Message-ID: <d822d70a-717a-e2b6-06a4-d6e276615bc1@posteo.de>
Subject: Re: J1939: Send messages without acknowledging
References: <PR0P264MB23096FC238E648331A32B5A492299@PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To: <PR0P264MB23096FC238E648331A32B5A492299@PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM>

--------------PX9h9hCCaMGv4Pa4vJ9tUEZM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

QW0gMTcuMTAuMjIgdW0gMTY6NTUgc2NocmllYiBTZWJhc3RpZW4gRkFCUkU6DQo+IEhlbGxv
LA0KPiANCj4gSSBhbSB3b3JraW5nIG9uIDUuNCBrZXJuZWwsIGFuZCBJIGhhdmUgdGhlIHNh
bWUgYmVoYXZpb3Igd2l0aCA1LjEwIGtlcm5lbCB2ZXJzaW9uLg0KPiBJIHJlcHJvZHVjZSB0
aGUgYmVoYXZpb3Igd2l0aCBhIGN1c3RvbSBhcHBsaWNhdGlvbi4gQSBqMTkzOSBzb2NrZXQg
aXMgY3JlYXRlZCB3aXRoIFNPX0JST0FEQ0FTVCBhbmQgU09fSjE5MzlfUFJPTUlTQyBvcHRp
b25zIGFuZCBpcyBiaW5kZWQuIFRoZSBhcHBsaWNhdGlvbiBzZW5kcyBhIGNsYWltIG1lc3Nh
Z2UgdGhlbiA1MCBicm9hZGNhc3QgbWVzc2FnZXMgaW4gbG9vcCAod2l0aG91dCB3YWl0aW5n
KSB3aXRoIHNpemUgZ3JlYXRlciB0aGFuIDggYnl0ZXMgKDUwKS4NCj4gDQo+IEV2ZXJ5IHNl
bmR0byBtZXRob2RzIHJldHVybiBzdWNjZXNzIGRpcmVjdGx5IGFuZCBzZXNzaW9ucyBhcmUg
c3RvcmVkIGluIHNrX3Nlc3Npb25fcXVldWUuDQo+IElmIHRoZSBjYW4gaXMgJ29uJyBidXQg
bm9ib2R5IGFja25vd2xlZGdlcywgYWZ0ZXIgc29tZSB0aW1lcywgdHJhbWVzIGFyZSBubyBs
b25nZXIgc2VudCAoRU5PQlVGUykgYnV0IHRoZSBhcHBsaWNhdGlvbiBkb2VzIG5vdCBoYXZl
IHRoaXMgaW5mb3JtYXRpb24gKHNlbmR0byByZXR1cm5lZCBzdWNjZXNzKS4NCj4gTW9yZW92
ZXIsIHR4cXVldWVsZW4gZG9lcyBub3QgaGF2ZSBpbXBhY3QgdG8gdGhpcyBiZWhhdmlvciAo
cXVldWUgc2l6ZSBzZWVtcyB0byBiZSBpbmZpbml0ZSkuDQo+IFRvIGZpbmlzaCwgY2xvc2lu
ZyBzb2NrZXQgd2lsbCB0YWtlIGEgbG9uZyB0aW1lIGRlcGVuZGluZyBvbiBza19zZXNzaW9u
X3F1ZXVlIHNpemUgYmVjYXVzZSBvZiBKMTkzOV9YVFBfVFhfUkVUUllfTElNSVQ6IGtlcm5l
bCBzZWVtcyB0byB0cnkgdG8gc2VuZCBldmVyeSBtZXNzYWdlIDEwMCB0aW1lcyBpZiBFTk9C
VUZTIGlzIHJlY2VpdmVkLg0KPiANCj4gSXMgaXQgdGhlIGV4cGVjdGVkIGJlaGF2aW9yPyBI
b3cgY2FuIHRoZSBhcHBsaWNhdGlvbiBrbm93IHRoYXQgbWVzc2FnZXMgYXJlIG5vIGxvbmdl
ciBzZW50Pw0KPiANCg0KSGVsbG8sDQoNCkkgaGF2ZW4ndCBkb25lIEoxOTM5IGZvciBhIHdo
aWxlIGJ1dCB0aGUgdHlwaWNhbCBzY2VuYXJpbyBpcyB0aGF0IHlvdSANCnNldCB1cCBhIENh
biBSYXcgU29ja2V0IHdpdGggc29tZSBmaWx0ZXJzIGFuZCB0aW1lb3V0IHNvY2tldCBvcHRp
b24gdG8gDQpyZWNlaXZlIHlvdXIgb3duIG1lc3NhZ2VzIGluIGFwcGxpY2F0aW9uLg0KWW91
IGRyb3AgZXZlcnl0aGluZyB1bnRpbCB0aGF0IHNvY2tldCB0aW1lb3V0IGhhcHBlbnMgd2hp
Y2ggaXMgdGhlIA0KdHJpZ2dlciB0byBzdG9wIHVuY29uZGl0aW9uYWwgc2VuZGluZyBpbiBh
cHBsaWNhdGlvbiB1bnRpbCBzb21ldGhpbmcgaXMgDQpyZWNlaXZlZCBhZ2Fpbi4NCg0KQWN0
dWFsbHkgSSB3b3VsZCBiZSBpbnRlcmVzdGVkIGlmIHRoZXJlIGFyZSBiZXR0ZXIgd2F5cyB0
byBkbyB0aGlzLg0KDQotLQ0KUGF0cmljaw0K

--------------PX9h9hCCaMGv4Pa4vJ9tUEZM--

--------------SCeewv7y3X85e6x3j60W30MS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE6VSgQlqXIUKDwAxHMeZuMM+vuE4FAmNNsYQFAwAAAAAACgkQMeZuMM+vuE6X
mA//bcA2fL0Z7o48gsEU9qXeRRWcDTAzIFEXBfai/hnqTAP4FO9eSFbPCNke74u3V50NcirFtBTq
s4Z6iMVLX0FDdyuO02Ag9YsLKj4LpjLbIVdSx0db7RUD2VuX7tU97SqR2bgI+b9UeOKeRT6aOYjR
rr4X6t5YODCFmjG+QbdKsl11pIPiS6zTZaZ3toMucrOBzn/EO4Uvp6wHQzSA0thnIR/Y78sNredW
G3AS8ACDK0EU+7djbnXWCbmtQHTZcg0JEsA3TrVc1un7xK1pHqsOCaOj8KHhJ/oYIHGcdKmtfEOM
HwA/A22WGYR7a+1In0duI+3lPUl5szxIKDzO78DTpdi7FPn62Ib+jUUp4wFaoOt4GhHDe5jYr1q0
tDKQz4KvoUOIK0UY8r8Jra9vr+BNtarDQZe80mDBIdbb6d85rdatp69C/wf4KaEmzRlvlz/e0pJR
feDyW4tqp6niO8pI587Gk7YIsREFnHrIh9Ui+R0XeBitxRqGmN531FDgQLz6NcSEuKrN9Pss1+qP
4f7VUhDuwBm0PNLuT7r3jZkp2N8Cw+3WdwCNxIjaUAZ0QxcZPxiw2WQ+Y9dgsNrTKqVOLdjrud4h
4LDxy2QIaoq6EXwHLKwExBXB5fk41aG5kj1IESSqn936h6iDpGTr+oj2YObuhS80MzyrOD0Qc3UP
SrI=
=/Cts
-----END PGP SIGNATURE-----

--------------SCeewv7y3X85e6x3j60W30MS--
