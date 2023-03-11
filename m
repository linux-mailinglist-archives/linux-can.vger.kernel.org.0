Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2996B5EB4
	for <lists+linux-can@lfdr.de>; Sat, 11 Mar 2023 18:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjCKRXk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 11 Mar 2023 12:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCKRXj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 11 Mar 2023 12:23:39 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613111F4A2
        for <linux-can@vger.kernel.org>; Sat, 11 Mar 2023 09:23:37 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id AEEDC2400C1
        for <linux-can@vger.kernel.org>; Sat, 11 Mar 2023 18:23:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1678555415; bh=D3YkDxJIy1Ae1RbOiDvQDG/C5lThDy4wkdQVi5S5psY=;
        h=Date:To:From:Subject:From;
        b=h/QjVzhGPNE0mDnp/Zud7wsv+rhTdo6pGJImlUArRBBlV0j5jtffDpORCrBqDqMzk
         BzFIFdBh//9EFyzEhX63CLFNt+4+GpmmMbJ75rvcrVswbLHx7mVe+IpX0R14aqI2qa
         iUXY+XB+MpSaV3Nn4zgOKCTVoldhrSmUMKIPImWpxjPxIjeSRR8D5Nu327E2lWP8Va
         iY+d9oFmYfmoKeTdn02TSSySk2f20QrBFL6GHAXIeBc//iJM5Hfhia4vkmYc/wYFur
         /YtZueMVvS6TeFzmolhGoydRd7YRbPyQ6z+Ll5mkFg3xcCk4a8uZigKpcs0kZkOLDF
         g8yw6lQAB8F8Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PYqWq2jlWz9rxB
        for <linux-can@vger.kernel.org>; Sat, 11 Mar 2023 18:23:35 +0100 (CET)
Message-ID: <fd198411-dc23-1c57-7599-d8b5214d0ce7@posteo.de>
Date:   Sat, 11 Mar 2023 17:23:34 +0000
MIME-Version: 1.0
To:     linux-can@vger.kernel.org
References: <20230311143446.3183-1-socketcan@hartkopp.net>
Content-Language: de-DE
From:   Patrick Menschel <menschel.p@posteo.de>
Subject: Re: [RFC PATCH] can: isotp: add module parameter for maximum pdu size
In-Reply-To: <20230311143446.3183-1-socketcan@hartkopp.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------biUkLm0WbMJ99rxDalW4pvbi"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------biUkLm0WbMJ99rxDalW4pvbi
Content-Type: multipart/mixed; boundary="------------q31Hnco3WTDxc0wnGoXV3KEq";
 protected-headers="v1"
From: Patrick Menschel <menschel.p@posteo.de>
To: linux-can@vger.kernel.org
Message-ID: <fd198411-dc23-1c57-7599-d8b5214d0ce7@posteo.de>
Subject: Re: [RFC PATCH] can: isotp: add module parameter for maximum pdu size
References: <20230311143446.3183-1-socketcan@hartkopp.net>
In-Reply-To: <20230311143446.3183-1-socketcan@hartkopp.net>

--------------q31Hnco3WTDxc0wnGoXV3KEq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCklNTyBpdCBpcyB0aGUgcmlnaHQgZGlyZWN0aW9uIGJ1dCBpdCBpcyBqdXN0
IGhhbGYgdGhlIHN0b3J5Lg0KDQpJIHJlbWVtYmVyIGhhdmluZyBwcm9ibGVtcyB3aXRoIHRo
ZSB0eHF1ZXVlbGVuIGV2ZW4gd2l0aCA0S0IgUERVcyANCm9yaWdpbmFsbHkgYW5kIEknbSBu
b3Qgc3VyZSBpZiB0aGF0IGhhcyBiZWVuIGltcHJvdmVkIGFscmVhZHkuDQoNCmh0dHBzOi8v
Z2l0bGFiLmNvbS9NZW5zY2hlbC9zb2NrZXRjYW4jY2FuLWlzb3RwLW92ZXJmbG93cy13aGVu
LXRoZS10eC1xdWV1ZS1pcy10b28tc21hbGwNCg0KSXQgd291bGQgYmUgZ3JlYXQgdG8gaGF2
ZSBhbGwgb2YgdGhvc2Ugc2l6ZSBvcHRpb25zIGluIG9uZSBwbGFjZSBhbmQgDQpzb21lIGlu
dGVsbGlnZW50IElPIGJ1ZmZlci4NCg0KQXBhcnQgZnJvbSB0aGF0IHRoZSBQRFUgc2l6ZSBk
b2VzIG5vdCBtYXR0ZXIgZm9yIFVEUywgYmVjYXVzZSBVRFMgc3BsaXRzIA0KdGhlIGRhdGEg
aW50byBjaHVua3MgdGhhdCBhcmUgc2VudCB2aWEgdHJhbnNmZXJfZGF0YSBzZXJ2aWNlIGFu
ZCANCmNvbmNhdGVuYXRlZCBvbiB0aGUgcmVjZWl2ZXIgZW5kIGFnYWluLCBzb3J0IG9mIHRo
ZSBwcm90b2NvbCdzIGJ1aWx0LWluIA0KSU8gYnVmZmVyLg0KDQpodHRwczovL2dpdGxhYi5j
b20vTWVuc2NoZWwvc29ja2V0Y2FuLXVkcy8tL2Jsb2IvbWFzdGVyL3Vkcy9wcm9ncmFtbWVy
LnB5I0w0OTUNCg0KQlIsDQpQYXRyaWNrDQotLQ0KDQpBbSAxMS4wMy4yMyB1bSAxNTozNCBz
Y2hyaWViIE9saXZlciBIYXJ0a29wcDoNCj4gV2l0aCBJU08gMTU3NjUtMjoyMDE2IHRoZSBQ
RFUgc2l6ZSBpcyBub3QgbGltaXRlZCB0byAyXjEyIC0gMSAoNDA5NSkgYnl0ZXMNCj4gYnV0
IGNhbiBiZSByZXByZXNlbnRlZCBhcyBhIDMyIGJpdCB1bnNpZ25lZCBpbnRlZ2VyIHZhbHVl
IHdoaWNoIGFsbG93cw0KPiAyXjMyIC0gMSBieXRlcyAofjRHQikuIFRoZSB1c2UtY2FzZXMg
bGlrZSBhdXRvbW90aXZlIHVuaWZpZWQgZGlhZ25vc3RpYw0KPiBzZXJ2aWNlcyAoVURTKSBh
bmQgZmxhc2hpbmcgb2YgRUNVcyBzdGlsbCB1c2UgdGhlIHNtYWxsIHN0YXRpYyBidWZmZXJz
DQo+IHdoaWNoIGFyZSBwcm92aWRlZCBhdCBzb2NrZXQgY3JlYXRpb24gdGltZS4NCj4gDQo+
IFdoZW4gYSB1c2UtY2FzZSByZXF1aXJlcyB0byB0cmFuc2ZlciBQRFVzIHVwIHRvIDEwMjUg
a0J5dGUgdGhlIG1heGltdW0NCj4gUERVIHNpemUgY2FuIG5vdyBiZSBleHRlbmRlZCBieSBz
ZXR0aW5nIHRoZSBtb2R1bGUgcGFyYW1ldGVyIG1heF9wZHVfc2l6ZS4NCj4gVGhlIGV4dGVu
ZGVkIHNpemUgYnVmZmVycyBhcmUgb25seSBhbGxvY2F0ZWQgb24gYSBwZXItc29ja2V0L2Nv
bm5lY3Rpb24NCj4gYmFzZSB3aGVuIG5lZWRlZCBhdCBydW4tdGltZS4NCj4gDQo+IExpbms6
IGh0dHBzOi8vZ2l0aHViLmNvbS9yYXNwYmVycnlwaS9saW51eC9pc3N1ZXMvNTM3MQ0KPiBT
aWduZWQtb2ZmLWJ5OiBPbGl2ZXIgSGFydGtvcHAgPHNvY2tldGNhbkBoYXJ0a29wcC5uZXQ+
DQoNCg==

--------------q31Hnco3WTDxc0wnGoXV3KEq--

--------------biUkLm0WbMJ99rxDalW4pvbi
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE6VSgQlqXIUKDwAxHMeZuMM+vuE4FAmQMuRYFAwAAAAAACgkQMeZuMM+vuE4l
pg//RODBfN7p17YlU1FYKXx+OWiwPQkftmwbOTNDQM1jVrSXbQhTwCWqmts3xc+X4oVPMegScMGB
61IxITbYbJ2981bu331wEgHBcfw76aUNoOn8wq/GMneGvmezee3HSVSerg3u+j3fh6vOhTSIm3h2
Q+BgBqZVlwjdtzSp74D78+jpjM856iwOqUEvHdqYGPU+oe1uexJ8q4sBVYzxzclNqAm9A72c/mCB
LAWfJSHNZyEfeGTIrZLn6cMenE3v3Ud/y0rP/fti3Kup+AgxJewMzpAE82lU4RUkcVp1yBNJK43L
gbJXWI436x9sLFt5lt0GS10WlvnhPm+v+BsQHorTAuYSsI/RRpAPIi0mIbOe2hpHcLwzx9Zq2ppy
Wb+JJM5aoCk401ki5qjJwkq/5/Hgvo5Bv7ndFh0QIpKkSA0MwaDETaT3p9ZBl0zF2G21YApGVupK
RmQI7L0REop62cqJUelf0ykUO8GwjyX9S8VWWEzOwZkl3LxGRFbPJVIAUozfcnFoXHhmhlnaoD5M
cYiHdyn1t4OS/Lk168DA0/MzTjxWq2B3pEZ1kZOcx9oVy7Rm9vWAjTp1rgozMrNo5Hntr05foakF
2sap21M2Z9rjhXM1VaOEDLjVBdNVMn5CiSBAdsnOAMXqUr0YOXrezsLOBjHWvl+BbtT3H05AaUzA
1PM=
=YWWe
-----END PGP SIGNATURE-----

--------------biUkLm0WbMJ99rxDalW4pvbi--
