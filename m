Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A351957C560
	for <lists+linux-can@lfdr.de>; Thu, 21 Jul 2022 09:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiGUHfZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 21 Jul 2022 03:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiGUHfV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 21 Jul 2022 03:35:21 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2075.outbound.protection.outlook.com [40.107.104.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFA9DE9E
        for <linux-can@vger.kernel.org>; Thu, 21 Jul 2022 00:35:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvYVM3hV08e5hpdFkxZKwqAENFEm8+2hR/1YjNrGO0FTYNTrrai6CJjYQJNh2wd8+vk+vfQgcB/25EzGIL5IV4qo4amL2QbDebqNGuo7fElD7SO/e7Z8AK7Yr8S58zzthaKLBfnL/6YJrwQiRhq655Ho8IKY1RPvBBWqAjI4E5wfroaXFUqidFFO1knoOp24loNom3om9JifKnL3vcF2PUtdqmdLFMQOzT46vf/YPTXfz0CXS+ioVHdFfssyjd9D6cNRA8PuN1fZWJ0DXUlWVzIGXkNl0CbZLID9Wt6G6mXh9p2f44VKZdUIPsBaKlWQ8VgsKLb0sGYmYfKYySZ8Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwPIvY1ZL5WL9n4wctQUNvxH3e3dxD/mZ5QOMIdfac0=;
 b=YfiDmXwAPUSEpb4D6OObVPxqL7rAeCM1DbqcvWwZV+71e5snquBJosazoFcjCYLKQt/ciOdDm6XjQMDGqHYwwgzIVdhtk4edckwWtZ4WmJa7f9nHBhkSNmVKTypAlbJLTUTjd5T+opYarA2xY0BptvG9o2SVuAemVpLO/yETSLVwKEtkpGteVxBrTZ437IhpMY335FTt3S5XPAXRJEwYA0Q8sVIgJ4MG2H2zUvtg2WcPzlAJUo6Er/Q/z5X2kI+G8qWkDAtjjfMeXzrNQCzc7qm+MH3J47KtG8dTTQCWK/bRvPDaJYvpJEYAYdTlIK1O9LdrT105I0pBDM33gPgPJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=krones.com; dmarc=pass action=none header.from=krones.com;
 dkim=pass header.d=krones.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krones.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwPIvY1ZL5WL9n4wctQUNvxH3e3dxD/mZ5QOMIdfac0=;
 b=e+ZnMvezob662JhaSssicjoIrjaKWzyn/OL7X20HuDrl1Hf/Dce2idgoRDUFcjyXatPDQ0qjw5nkPwZmoTMJNecb/NW9tVXJSzIMj0EvHZZIKa4FOs04HMlT4hZj8uxuOiXKuCXCCYJ6JJyMtg4Bk/c0PRy+i6B6isBdQqxP9VdBRBH+oQoj2rqfnpzmctBoBpGoGW8hYJlmbokm1H0ml7HgAW9rAGo3+oHa+DnVEIyVJ3xEy70QYgWXhExoXkyPEpdVemPRudavS3kaQfuyPSMHxdOHnVARVQt3OBQncG70UUqaUEMFVyt27rtSmg0uVwJ4SBLw/R/4J5N13dD8mw==
Received: from AM0PR05MB5762.eurprd05.prod.outlook.com (2603:10a6:208:11d::23)
 by AS4PR05MB9181.eurprd05.prod.outlook.com (2603:10a6:20b:4ec::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 07:35:14 +0000
Received: from AM0PR05MB5762.eurprd05.prod.outlook.com
 ([fe80::f5b1:d9e:53a7:2626]) by AM0PR05MB5762.eurprd05.prod.outlook.com
 ([fe80::f5b1:d9e:53a7:2626%4]) with mapi id 15.20.5458.018; Thu, 21 Jul 2022
 07:35:14 +0000
From:   "Kaesbauer, Michael" <Michael.Kaesbauer@krones.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: AW: Massive kernel messages by can_create_echo_skb()
Thread-Topic: Massive kernel messages by can_create_echo_skb()
Thread-Index: AdiasuNIgIQIQti8Qi20r+bgFzcDqgAoz2uAAF9ADyA=
Date:   Thu, 21 Jul 2022 07:35:14 +0000
Message-ID: <AM0PR05MB57625ED5D383DC24C5DB5DE68F919@AM0PR05MB5762.eurprd05.prod.outlook.com>
References: <AM0PR05MB57628BBAD26128E47F9850608F8C9@AM0PR05MB5762.eurprd05.prod.outlook.com>
 <20220719095843.GK24373@pengutronix.de>
In-Reply-To: <20220719095843.GK24373@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=krones.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2ff22d5-4546-4064-ee4b-08da6aeb8d00
x-ms-traffictypediagnostic: AS4PR05MB9181:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NdlNdbthl9NsvpRV6UjPPwY3l3Vq2Utp4VpXotf8wCc/VqSrv6VPwY2rNX3ZwHIjQC60bdfrlddCxZtxxLxgVN9FbkOJyZ6lKNmAbpPRSzsp+NVDvGOmv9eJFC3d8iKb0iRiN0tY8H55aJe2IFneVvtAetqPYSxvP5fp0y/6pQlxDMPiZrbCj4jWuI3PsHTTiCT9OFLOHcaLboAGNBcTyvE96FSpsRnet/PmJpbmT3Ai+y9uq5hq3nmD2QyezaP8gCMF8FgTUh0s3OGyXudZdC2Yx94gjck6gqbbnv3gPGPBFRhoWJC7dobDNnIHymohehqHguAk9UCQy3krfSWX2QeyiV2n8SdrjLWym/W40iGmf6ObXCMN4P2G5jfwMAoeaxeS6HZLbaF1KretVlGKtjQzbbOVXqUvYzLvOMTlSZvo0GNoOEH1sPObWhLxopUpsxg1k0MDMQNAn57XAuLDEtCJwzGeZ54gvqVFs2eq+3FdrOmEyQ0zwMbrU0fO/dhiLJapN7oQbEtATGpN+8iAHa4ozvxorWdsdPDyw4kd8T/+B60NFtKcMWlFkGo2hrkTpWalUbeSxRerj3WS5XHfXB1s8dXkYx0TtcElXKFi74S9+khTkUSF/XUhLRf8L0Lj3o22LXHwucpwDsljQO50JXYfm3mt4qPLp/VOjySMgxdLnJ0dSvBab9b8UBoRXhSrm+xBmPi6nNm0QVtIOzzBQfMnTp4WX1kEqo2UWvdf2+hFDe2LWYnxYbppIgQO1WLUG+RZWLsP72/l1NWKM8Ggu2pND4MileDDOjfXHDINgEtlKwJN09/sVTUi4yvwMmftK6aSsbnOnvhEeUmfberZ2dFrAOA5H7hlzpGgus9mgq4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5762.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(41300700001)(6506007)(7696005)(478600001)(33656002)(15974865002)(86362001)(38070700005)(71200400001)(6916009)(9686003)(83380400001)(186003)(54906003)(316002)(45080400002)(966005)(66556008)(55016003)(4326008)(8936002)(5660300002)(66446008)(30864003)(52536014)(66946007)(66476007)(2906002)(8676002)(64756008)(76116006)(15650500001)(122000001)(38100700002)(66574015)(14583001)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?g6TWR3eAiTQuuXwMrXYoHL7ELYY84mZGJ3+I5cmL7vLaSnRHqiG3nlmcYP?=
 =?iso-8859-1?Q?eY2LxfkcxiM5clGPyklZbaG3p6uaaS0E4YIqEoWNwwaHDqtwHfkfszmWuB?=
 =?iso-8859-1?Q?ywZl06s8KNSps+QFl6XQkNqRDf0y1i0JQy8E5X5xxku0mBz9Tzm6VzzgYr?=
 =?iso-8859-1?Q?MU5FlyaH/4p/24lXrYNbfBqUu4R7y/Evi/WHIAXWCA+u3+RZo/wD5kGfDs?=
 =?iso-8859-1?Q?Z4Fr6PxwUViD6jd3wIQVmVA+bencpAkvXl6THREqbnrgA5s9t/0cwO4NfZ?=
 =?iso-8859-1?Q?QWWqwNi9UPGgVpIspYYA7Jr1QriDpCuRyCl8ufdU5Nk2EAlvjJFOUUCmuM?=
 =?iso-8859-1?Q?84QQAjr2xrxskRe9qQcqFXyD+XjblEvz9kPZ2+ZzZYyRmJxfMdzrQzxsQN?=
 =?iso-8859-1?Q?TPM/pcccJREIJsVbk84TKYGN3/D/Y5USlhCNOGos3/Z+ec3CtBPcs7RvtH?=
 =?iso-8859-1?Q?Krpse3IzHiiZfTKyoE0V6qpc+Xt9eoFnwwl7FDyvYxAMHgKaiStwaEZ26n?=
 =?iso-8859-1?Q?AVtKRHzAYsbFZorfe4/wghqD3hnolVy14EvN/JQarIONWWU391EwVFhbW7?=
 =?iso-8859-1?Q?ykcpff6wjUUXUqI+hwkO+0pXlgd+GYW/4BUXDHvi3XHG5sTgbV2gSAbFuo?=
 =?iso-8859-1?Q?MUOo77jFTAN7bSA0JIL4KiTWtDy0KYVO3zC/zT87c4E/jp6h24k0GB8mLL?=
 =?iso-8859-1?Q?/zzPiPIYKfbHaCbuTNtR3PVNzWN1mhI4sCp0KoVCSx/w6FwcxJ6mA751zp?=
 =?iso-8859-1?Q?nl9RQZ1kc3yct2A9OYzcYIzeCsmLVqyc48ELVdhstSoxpXfqKz4EhLkd3s?=
 =?iso-8859-1?Q?C/lOUNQCOuZcA2WraR1dIAtFjrk1LNVgTJ89UIeR+11JWw3TWvmTPGy1rI?=
 =?iso-8859-1?Q?91Z8CaLAC/+L9g89BMl/KY/Y2RfElbMMy5P7hPr43mVA5tiYHXzPRKid2n?=
 =?iso-8859-1?Q?33jsBskKm3ye6nI0GggsLKf0Es7L6GkntTulX+3I8SM8sUp/hnZPnqIywb?=
 =?iso-8859-1?Q?KZSMEIiOTHsl4ylJfIGjWcere1hIyG8YrqPr2Nxe3D02pp8a2Yz35IALx/?=
 =?iso-8859-1?Q?NPLZqLIx+P6Wc6rxBTUmAUR7NXjcfmwShyoXUm5ia+tQou5PI46BoMbxVb?=
 =?iso-8859-1?Q?F/O4o4P7lSH7NdUmprCsCdN9KBGcRyZIbPHt0penZhsK6XBPY8OcZNrWpi?=
 =?iso-8859-1?Q?n9cTct0V+chpSRXGr4qDqSuv0sbBuC1gHsUsH9j9Wo/4tlrZUJXlp56pTU?=
 =?iso-8859-1?Q?yFOrXp3HE22YIUw6clEImL3opD+h/JLIT8ozT5ImF4XceUm4kjOT4VQq6l?=
 =?iso-8859-1?Q?5IcnR7rut+o+AkgFldmnLG1qy+vwpnoarWU0jsQFRDei40HcvJxDzJmNvK?=
 =?iso-8859-1?Q?mHgDu4y4m0+OhC8LRY63KWxn2V5a3WpcvW3A75wLikugY17p/B3rmlnEDn?=
 =?iso-8859-1?Q?Gn9zE85PeLdtvX272WUJomkQ9/t6NRF7yaAEFWvasoBZA5iQVUAOWLs/6D?=
 =?iso-8859-1?Q?d9kuKeUzYSoxW4OCQcWW3yjxVJivXHwE71n5DSJBNmEAIjP9HfUxLPG3aE?=
 =?iso-8859-1?Q?zZUfweNE1bipcd6M4pAfkz0vuorKl98oS+2/KRzzfWgIqfn0XLkz7pRCkm?=
 =?iso-8859-1?Q?mh+Y/cOWE7/rK2/AHJcXqLAUbQr+468yBSEk7FDvKxyQvNoB4+kDUF9bYh?=
 =?iso-8859-1?Q?Aqs+mQJqSMNBr8khl58e6w0o8RbOw/WIsH10Qy0qkCOio8tmZlnCXluWPZ?=
 =?iso-8859-1?Q?n6lw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: krones.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB5762.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ff22d5-4546-4064-ee4b-08da6aeb8d00
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 07:35:14.1541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1dd2af38-50fb-445c-8760-4bd948765fc7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cvG2ZDHz06R73+ctgtEIEmjoYz+wdOeSQNvbyD9ai2viwYLJVLepb0SmzipzpkIAx+yd/dZAkttrEa9jd1cWYhns4NjMWRCxwvDeaQ7J3vQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR05MB9181
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Oleksij,

thanks for your reply.

> Von: Oleksij Rempel <o.rempel@pengutronix.de>
> Gesendet: Dienstag, 19. Juli 2022 11:59
> An: Kaesbauer, Michael <Michael.Kaesbauer@krones.com>
> Cc: linux-can@vger.kernel.org; Marc Kleine-Budde <mkl@pengutronix.de>
> Betreff: Re: Massive kernel messages by can_create_echo_skb()
>
> Hello Michael,
>
> On Mon, Jul 18, 2022 at 02:30:29PM +0000, Kaesbauer, Michael wrote:
> > Hello Oleksij,
> >
> > after updating from kernel version 4.17.10 to 4.19.237 I am facing mass=
ive
> kernel messages when sending CAN telegrams via an CC770 compatible
> controller by using the drivers cc770.ko and can_dev.ko.
>
> Initial patch was developed and tested on top of 5.x kernel. I better ask=
 CAN
> community if some one has idea on what is going wrong here.

Sounds good. If necessary I could support with testing upcoming patches. An=
 appropriate patch for kernel version 4.19.* would be very helpful.

>
> CCing CAN maeling list.
>
> > Here an excerpt (more data at attachment excerpt.txt):
> > Jun 24 09:44:01 (none) kernel: [67592.681525] ------------[ cut here
> > ]------------ Jun 24 09:44:01 (none) kernel: [67592.681539] WARNING:
> > CPU: 2 PID: 0 at /home/buildroot/darthost_APC910_wl/kernel/linux-
> 4.19.237/net/core/skbuff.c:624 skb_release_head_state+0x55/0x60 Jun 24
> 09:44:01 (none) kernel: [67592.681540] Modules linked in: elo cc770_isa c=
c770
> can_dev can_raw can e1000e pl2303 usbserial ptp pps_core
> x86_pkg_temp_thermal
> > Jun 24 09:44:01 (none) kernel: [67592.681545] CPU: 2 PID: 0 Comm:
> swapper/2 Tainted: G        W         4.19.237_dev-tomoyo-ima #1
> > Jun 24 09:44:01 (none) kernel: [67592.681546] Hardware name: Bernecker
> > + Rainer  Industrie-Elektronik  APC910/TS170, BIOS W1.22 02/03/2022
> > Jun 24 09:44:01 (none) kernel: [67592.681549] RIP:
> > 0010:skb_release_head_state+0x55/0x60
> > Jun 24 09:44:01 (none) kernel: [67592.681550] Code: 81 e2 00 00 0f 00
> > 75 16 48 89 df 5b e9 a4 f9 31 00 5b c3 48 83 e7 fe e8 f9 ff 01 00 eb
> > ca 48 c7 c7 68 57 d8 81 e8 28 8e 0e 00 <0f> 0b 48 8b 43 60 eb d6 0f 1f
> > 00 53 48 89 fb e8 97 ff ff ff 48 83 Jun 24 09:44:01 (none) kernel:
> > [67592.681552] RSP: 0018:ffff888267b03e78 EFLAGS: 00010086 Jun 24
> > 09:44:01 (none) kernel: [67592.681553] RAX: 0000000000000024 RBX:
> > ffff8881fdc7e100 RCX: ffffffff82035638 Jun 24 09:44:01 (none) kernel:
> > [67592.681554] RDX: 0000000000000000 RSI: 0000000000000092 RDI:
> > ffffffff825587ac Jun 24 09:44:01 (none) kernel: [67592.681555] RBP:
> > 0000000000000000 R08: 0000000000e992c4 R09: 0000000000000007 Jun 24
> > 09:44:01 (none) kernel: [67592.681556] R10: 0000000000000000 R11:
> > ffffffff8255a7ed R12: ffff888266a7e000 Jun 24 09:44:01 (none) kernel:
> > [67592.681557] R13: ffff888246313500 R14: ffff888266a7e000 R15:
> 0000000000000055 Jun 24 09:44:01 (none) kernel: [67592.681558] FS:
> 0000000000000000(0000) GS:ffff888267b00000(0000)
> knlGS:0000000000000000 Jun 24 09:44:01 (none) kernel: [67592.681559] CS:
> 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 Jun 24 09:44:01 (none) kerne=
l:
> [67592.681560] CR2: 0000000000000000 CR3: 000000000200a001 CR4:
> 00000000003606e0 Jun 24 09:44:01 (none) kernel: [67592.681561] DR0:
> 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 Jun 24
> 09:44:01 (none) kernel: [67592.681562] DR3: 0000000000000000 DR6:
> 00000000fffe0ff0 DR7: 0000000000000400 Jun 24 09:44:01 (none) kernel:
> [67592.681562] Call Trace:
> > Jun 24 09:44:01 (none) kernel: [67592.681564]  <IRQ> Jun 24 09:44:01
> > (none) kernel: [67592.681567]  skb_release_all+0x9/0x20 Jun 24
> > 09:44:01 (none) kernel: [67592.681568]  consume_skb+0x27/0x90 Jun 24
> > 09:44:01 (none) kernel: [67592.681571]  can_put_echo_skb+0xc5/0x120
> > [can_dev] Jun 24 09:44:01 (none) kernel: [67592.681573]
> > cc770_interrupt+0x220/0x600 [cc770] Jun 24 09:44:01 (none) kernel:
> > [67592.681575]  ? timerqueue_add+0x58/0x60 Jun 24 09:44:01 (none)
> > kernel: [67592.681578]  __handle_irq_event_percpu+0x41/0x1a0
> > Jun 24 09:44:01 (none) kernel: [67592.681580]
> > handle_irq_event_percpu+0x2b/0x70 Jun 24 09:44:01 (none) kernel:
> > [67592.681582]  handle_irq_event+0x22/0x40 Jun 24 09:44:01 (none)
> > kernel: [67592.681584]  handle_edge_irq+0x75/0x190 Jun 24 09:44:01
> > (none) kernel: [67592.681586]  handle_irq+0x17/0x20 Jun 24 09:44:01
> > (none) kernel: [67592.681588]  do_IRQ+0x3c/0xd0 Jun 24 09:44:01 (none)
> > kernel: [67592.681590]  common_interrupt+0xf/0xf Jun 24 09:44:01
> > (none) kernel: [67592.681591]  </IRQ> Jun 24 09:44:01 (none) kernel:
> > [67592.681594] RIP: 0010:cpuidle_enter_state+0xb2/0x310
> > Jun 24 09:44:01 (none) kernel: [67592.681595] Code: c3 8b 05 99 31 a4
> > 00 85 c0 0f 8f 33 01 00 00 31 ff e8 c2 06 9e ff 45 84 f6 0f 85 f1 00
> > 00 00 fb 48 ba cf f7 53 e3 a5 9b c4 20 <4c> 29 fb 48 89 d8 48 c1 fb 3f
> > 48 f7 ea b8 ff ff ff 7f 48 c1 fa 07 Jun 24 09:44:01 (none) kernel:
> > [67592.681596] RSP: 0018:ffffc900000a7e90 EFLAGS: 00000246 ORIG_RAX:
> > ffffffffffffffdc Jun 24 09:44:01 (none) kernel: [67592.681598] RAX:
> > ffff888267b24840 RBX: 00003d79a5c4f930 RCX: 000000000000001f Jun 24
> > 09:44:01 (none) kernel: [67592.681599] RDX: 20c49ba5e353f7cf RSI:
> > 000000002f32988b RDI: 0000000000000000 Jun 24 09:44:01 (none) kernel:
> > [67592.681600] RBP: 0000000000000008 R08: 0000000000000000 R09:
> > 0000000000024100 Jun 24 09:44:01 (none) kernel: [67592.681601] R10:
> > ffffc900000a7e78 R11: 0000000000003cc2 R12: ffffffff82091878 Jun 24
> > 09:44:01 (none) kernel: [67592.681601] R13: ffff888267b2be00 R14:
> > 0000000000000000 R15: 00003d79a5b3bdb2 Jun 24 09:44:01 (none) kernel:
> > [67592.681605]  do_idle+0x1d6/0x230 Jun 24 09:44:01 (none) kernel:
> > [67592.681607]  cpu_startup_entry+0x6a/0x70 Jun 24 09:44:01 (none)
> > kernel: [67592.681610]  start_secondary+0x183/0x1b0 Jun 24 09:44:01
> > (none) kernel: [67592.681611]  secondary_startup_64+0xa4/0xb0 Jun 24
> > 09:44:01 (none) kernel: [67592.681613] ---[ end trace 7155571a10d3a959
> > ]---
> >
> > As the kernel logs are redirected to a file at my system, the disk is r=
unning
> out of space after some time.
> >
> > Another user, Patric Hopfgarten, has reported the same error at this po=
st:
> >
> https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugs
> > .launchpad.net%2Fubuntu%2F%2Bsource%2Flinux-signed-
> hwe%2F%2Bbug%2F1915
> >
> 035&amp;data=3D05%7C01%7Cmichael.kaesbauer%40krones.com%7Cb8b9fb0
> 5e6c54b
> >
> d3799608da696d4470%7C1dd2af3850fb445c87604bd948765fc7%7C0%7C0%7C
> 637938
> >
> 215277521352%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> QIjoiV2luM
> >
> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DZ9g
> 2V49Y3N
> > D0EQpuEz2EpFflDZr8TieO1WYPD0XCH3A%3D&amp;reserved=3D0
> >
> > After some research I discovered the change made at commit
> ef02687fc78099ef3fd2eb8a150c2823fe2d9061:
> > https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
.
> >
> kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fstable%2Flinux.git%
> 2Fc
> > ommit%2Finclude%2Flinux%2Fcan%3Fh%3Dlinux-
> 4.19.y%26id%3Def02687fc78099
> >
> ef3fd2eb8a150c2823fe2d9061&amp;data=3D05%7C01%7Cmichael.kaesbauer%4
> 0kron
> >
> es.com%7Cb8b9fb05e6c54bd3799608da696d4470%7C1dd2af3850fb445c87604
> bd948
> >
> 765fc7%7C0%7C0%7C637938215277521352%7CUnknown%7CTWFpbGZsb3d8
> eyJWIjoiMC
> >
> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%
> 7C%7C%
> >
> 7C&amp;sdata=3D9aDcP2CqVL2YAbEa2jZUbj5yxJ6pAbVBLIiysDoLKkk%3D&amp
> ;reserv
> > ed=3D0
> >
> > For testing purposes I reverted only this commit at kernel version 4.19=
.237
> and all the logging problems disappeared.
> >
> > I think the original reason:
> > "... The problem shows up in the j1939 stack, when it clones the
> > incoming skb, which detects the already 0 refcount. ..."
> > for that commit is not valid for kernel version 4.19.237 as this versio=
n does
> not support the j1939 stack at mainline.
> >
> > What solution can you imagine for solving the described problem?
> >
> > Looking forward to get your feedback.
> >
> >
> > Kind regards
> >
> > Michael K=E4sbauer
> > Software Developer of Sensor Technology CRD Inspection Technology
> >
> > Krones AG
> > B=F6hmerwaldstra=DFe 5
> > 93073 Neutraubling
> > Germany
> >
> > Phone: +49 (0)9401 70-1853
> > E-Mail:
> > michael.kaesbauer@krones.com<mailto:michael.kaesbauer@krones.com>
> > Internet: www.krones.com<http://www.krones.com>
> > ...
> > Jun 24 09:44:01 (none) kernel: [67592.681525] ------------[ cut here
> > ]------------ Jun 24 09:44:01 (none) kernel: [67592.681539] WARNING:
> > CPU: 2 PID: 0 at /home/buildroot/darthost_APC910_wl/kernel/linux-
> 4.19.237/net/core/skbuff.c:624 skb_release_head_state+0x55/0x60 Jun 24
> 09:44:01 (none) kernel: [67592.681540] Modules linked in: elo cc770_isa c=
c770
> can_dev can_raw can e1000e pl2303 usbserial ptp pps_core
> x86_pkg_temp_thermal
> > Jun 24 09:44:01 (none) kernel: [67592.681545] CPU: 2 PID: 0 Comm:
> swapper/2 Tainted: G        W         4.19.237_dev-tomoyo-ima #1
> > Jun 24 09:44:01 (none) kernel: [67592.681546] Hardware name: Bernecker
> > + Rainer  Industrie-Elektronik  APC910/TS170, BIOS W1.22 02/03/2022
> > Jun 24 09:44:01 (none) kernel: [67592.681549] RIP:
> > 0010:skb_release_head_state+0x55/0x60
> > Jun 24 09:44:01 (none) kernel: [67592.681550] Code: 81 e2 00 00 0f 00
> > 75 16 48 89 df 5b e9 a4 f9 31 00 5b c3 48 83 e7 fe e8 f9 ff 01 00 eb
> > ca 48 c7 c7 68 57 d8 81 e8 28 8e 0e 00 <0f> 0b 48 8b 43 60 eb d6 0f 1f
> > 00 53 48 89 fb e8 97 ff ff ff 48 83 Jun 24 09:44:01 (none) kernel:
> > [67592.681552] RSP: 0018:ffff888267b03e78 EFLAGS: 00010086 Jun 24
> > 09:44:01 (none) kernel: [67592.681553] RAX: 0000000000000024 RBX:
> > ffff8881fdc7e100 RCX: ffffffff82035638 Jun 24 09:44:01 (none) kernel:
> > [67592.681554] RDX: 0000000000000000 RSI: 0000000000000092 RDI:
> > ffffffff825587ac Jun 24 09:44:01 (none) kernel: [67592.681555] RBP:
> > 0000000000000000 R08: 0000000000e992c4 R09: 0000000000000007 Jun 24
> > 09:44:01 (none) kernel: [67592.681556] R10: 0000000000000000 R11:
> > ffffffff8255a7ed R12: ffff888266a7e000 Jun 24 09:44:01 (none) kernel:
> > [67592.681557] R13: ffff888246313500 R14: ffff888266a7e000 R15:
> 0000000000000055 Jun 24 09:44:01 (none) kernel: [67592.681558] FS:
> 0000000000000000(0000) GS:ffff888267b00000(0000)
> knlGS:0000000000000000 Jun 24 09:44:01 (none) kernel: [67592.681559] CS:
> 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 Jun 24 09:44:01 (none) kerne=
l:
> [67592.681560] CR2: 0000000000000000 CR3: 000000000200a001 CR4:
> 00000000003606e0 Jun 24 09:44:01 (none) kernel: [67592.681561] DR0:
> 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 Jun 24
> 09:44:01 (none) kernel: [67592.681562] DR3: 0000000000000000 DR6:
> 00000000fffe0ff0 DR7: 0000000000000400 Jun 24 09:44:01 (none) kernel:
> [67592.681562] Call Trace:
> > Jun 24 09:44:01 (none) kernel: [67592.681564]  <IRQ> Jun 24 09:44:01
> > (none) kernel: [67592.681567]  skb_release_all+0x9/0x20 Jun 24
> > 09:44:01 (none) kernel: [67592.681568]  consume_skb+0x27/0x90 Jun 24
> > 09:44:01 (none) kernel: [67592.681571]  can_put_echo_skb+0xc5/0x120
> > [can_dev] Jun 24 09:44:01 (none) kernel: [67592.681573]
> > cc770_interrupt+0x220/0x600 [cc770] Jun 24 09:44:01 (none) kernel:
> > [67592.681575]  ? timerqueue_add+0x58/0x60 Jun 24 09:44:01 (none)
> > kernel: [67592.681578]  __handle_irq_event_percpu+0x41/0x1a0
> > Jun 24 09:44:01 (none) kernel: [67592.681580]
> > handle_irq_event_percpu+0x2b/0x70 Jun 24 09:44:01 (none) kernel:
> > [67592.681582]  handle_irq_event+0x22/0x40 Jun 24 09:44:01 (none)
> > kernel: [67592.681584]  handle_edge_irq+0x75/0x190 Jun 24 09:44:01
> > (none) kernel: [67592.681586]  handle_irq+0x17/0x20 Jun 24 09:44:01
> > (none) kernel: [67592.681588]  do_IRQ+0x3c/0xd0 Jun 24 09:44:01 (none)
> > kernel: [67592.681590]  common_interrupt+0xf/0xf Jun 24 09:44:01
> > (none) kernel: [67592.681591]  </IRQ> Jun 24 09:44:01 (none) kernel:
> > [67592.681594] RIP: 0010:cpuidle_enter_state+0xb2/0x310
> > Jun 24 09:44:01 (none) kernel: [67592.681595] Code: c3 8b 05 99 31 a4
> > 00 85 c0 0f 8f 33 01 00 00 31 ff e8 c2 06 9e ff 45 84 f6 0f 85 f1 00
> > 00 00 fb 48 ba cf f7 53 e3 a5 9b c4 20 <4c> 29 fb 48 89 d8 48 c1 fb 3f
> > 48 f7 ea b8 ff ff ff 7f 48 c1 fa 07 Jun 24 09:44:01 (none) kernel:
> > [67592.681596] RSP: 0018:ffffc900000a7e90 EFLAGS: 00000246 ORIG_RAX:
> > ffffffffffffffdc Jun 24 09:44:01 (none) kernel: [67592.681598] RAX:
> > ffff888267b24840 RBX: 00003d79a5c4f930 RCX: 000000000000001f Jun 24
> > 09:44:01 (none) kernel: [67592.681599] RDX: 20c49ba5e353f7cf RSI:
> > 000000002f32988b RDI: 0000000000000000 Jun 24 09:44:01 (none) kernel:
> > [67592.681600] RBP: 0000000000000008 R08: 0000000000000000 R09:
> > 0000000000024100 Jun 24 09:44:01 (none) kernel: [67592.681601] R10:
> > ffffc900000a7e78 R11: 0000000000003cc2 R12: ffffffff82091878 Jun 24
> > 09:44:01 (none) kernel: [67592.681601] R13: ffff888267b2be00 R14:
> > 0000000000000000 R15: 00003d79a5b3bdb2 Jun 24 09:44:01 (none) kernel:
> > [67592.681605]  do_idle+0x1d6/0x230 Jun 24 09:44:01 (none) kernel:
> [67592.681607]  cpu_startup_entry+0x6a/0x70 Jun 24 09:44:01 (none) kernel=
:
> [67592.681610]  start_secondary+0x183/0x1b0 Jun 24 09:44:01 (none) kernel=
:
> [67592.681611]  secondary_startup_64+0xa4/0xb0 Jun 24 09:44:01 (none)
> kernel: [67592.681613] ---[ end trace 7155571a10d3a959 ]--- Jun 24 09:44:=
01
> (none) kernel: [67593.322902] ------------[ cut here ]------------ Jun 24=
 09:44:01
> (none) kernel: [67593.322916] WARNING: CPU: 2 PID: 0 at
> /home/buildroot/darthost_APC910_wl/kernel/linux-
> 4.19.237/net/core/skbuff.c:624 skb_release_head_state+0x55/0x60 Jun 24
> 09:44:01 (none) kernel: [67593.322917] Modules linked in: elo cc770_isa c=
c770
> can_dev can_raw can e1000e pl2303 usbserial ptp pps_core
> x86_pkg_temp_thermal
> > Jun 24 09:44:01 (none) kernel: [67593.322922] CPU: 2 PID: 0 Comm:
> swapper/2 Tainted: G        W         4.19.237_dev-tomoyo-ima #1
> > Jun 24 09:44:01 (none) kernel: [67593.322923] Hardware name: Bernecker
> > + Rainer  Industrie-Elektronik  APC910/TS170, BIOS W1.22 02/03/2022
> > Jun 24 09:44:01 (none) kernel: [67593.322926] RIP:
> > 0010:skb_release_head_state+0x55/0x60
> > Jun 24 09:44:01 (none) kernel: [67593.322927] Code: 81 e2 00 00 0f 00
> > 75 16 48 89 df 5b e9 a4 f9 31 00 5b c3 48 83 e7 fe e8 f9 ff 01 00 eb
> > ca 48 c7 c7 68 57 d8 81 e8 28 8e 0e 00 <0f> 0b 48 8b 43 60 eb d6 0f 1f
> > 00 53 48 89 fb e8 97 ff ff ff 48 83 Jun 24 09:44:01 (none) kernel:
> > [67593.322928] RSP: 0018:ffff888267b03e78 EFLAGS: 00010086 Jun 24
> > 09:44:01 (none) kernel: [67593.322930] RAX: 0000000000000024 RBX:
> > ffff888246313400 RCX: ffffffff82035638 Jun 24 09:44:01 (none) kernel:
> > [67593.322931] RDX: 0000000000000000 RSI: 0000000000000092 RDI:
> > ffffffff825587ac Jun 24 09:44:01 (none) kernel: [67593.322932] RBP:
> > 0000000000000000 R08: 0000000000e992f2 R09: 0000000000000007 Jun 24
> > 09:44:01 (none) kernel: [67593.322933] R10: 0000000000000000 R11:
> > ffffffff8255a7ed R12: ffff888266a7e000 Jun 24 09:44:01 (none) kernel:
> > [67593.322934] R13: ffff888246313300 R14: ffff888266a7e000 R15:
> 0000000000000055 Jun 24 09:44:01 (none) kernel: [67593.322935] FS:
> 0000000000000000(0000) GS:ffff888267b00000(0000)
> knlGS:0000000000000000 Jun 24 09:44:01 (none) kernel: [67593.322936] CS:
> 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 Jun 24 09:44:01 (none) kerne=
l:
> [67593.322937] CR2: 00007f7fd9d60008 CR3: 000000000200a002 CR4:
> 00000000003606e0 Jun 24 09:44:01 (none) kernel: [67593.322938] DR0:
> 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 Jun 24
> 09:44:01 (none) kernel: [67593.322939] DR3: 0000000000000000 DR6:
> 00000000fffe0ff0 DR7: 0000000000000400 Jun 24 09:44:01 (none) kernel:
> [67593.322939] Call Trace:
> > Jun 24 09:44:01 (none) kernel: [67593.322941]  <IRQ> Jun 24 09:44:01
> > (none) kernel: [67593.322944]  skb_release_all+0x9/0x20 Jun 24
> > 09:44:01 (none) kernel: [67593.322945]  consume_skb+0x27/0x90 Jun 24
> > 09:44:01 (none) kernel: [67593.322948]  can_put_echo_skb+0xc5/0x120
> > [can_dev] Jun 24 09:44:01 (none) kernel: [67593.322950]
> > cc770_interrupt+0x220/0x600 [cc770] Jun 24 09:44:01 (none) kernel:
> > [67593.322954]  __handle_irq_event_percpu+0x41/0x1a0
> > Jun 24 09:44:01 (none) kernel: [67593.322956]
> > handle_irq_event_percpu+0x2b/0x70 Jun 24 09:44:01 (none) kernel:
> > [67593.322958]  handle_irq_event+0x22/0x40 Jun 24 09:44:01 (none)
> > kernel: [67593.322960]  handle_edge_irq+0x75/0x190 Jun 24 09:44:01
> > (none) kernel: [67593.322961]  handle_irq+0x17/0x20 Jun 24 09:44:01
> > (none) kernel: [67593.322963]  do_IRQ+0x3c/0xd0 Jun 24 09:44:01 (none)
> > kernel: [67593.322966]  common_interrupt+0xf/0xf Jun 24 09:44:01
> > (none) kernel: [67593.322967]  </IRQ> Jun 24 09:44:01 (none) kernel:
> > [67593.322970] RIP: 0010:cpuidle_enter_state+0xb2/0x310
> > Jun 24 09:44:01 (none) kernel: [67593.322971] Code: c3 8b 05 99 31 a4
> > 00 85 c0 0f 8f 33 01 00 00 31 ff e8 c2 06 9e ff 45 84 f6 0f 85 f1 00
> > 00 00 fb 48 ba cf f7 53 e3 a5 9b c4 20 <4c> 29 fb 48 89 d8 48 c1 fb 3f
> > 48 f7 ea b8 ff ff ff 7f 48 c1 fa 07 Jun 24 09:44:01 (none) kernel:
> > [67593.322972] RSP: 0018:ffffc900000a7e90 EFLAGS: 00000246 ORIG_RAX:
> > ffffffffffffffdc Jun 24 09:44:01 (none) kernel: [67593.322973] RAX:
> > ffff888267b24840 RBX: 00003d79cbff9cb5 RCX: 000000000000001f Jun 24
> > 09:44:01 (none) kernel: [67593.322974] RDX: 20c49ba5e353f7cf RSI:
> > 000000002f32988b RDI: 0000000000000000 Jun 24 09:44:01 (none) kernel:
> > [67593.322975] RBP: 0000000000000008 R08: 0000000000000000 R09:
> > 0000000000024100 Jun 24 09:44:01 (none) kernel: [67593.322976] R10:
> > ffffc900000a7e78 R11: 0000000000000201 R12: ffffffff82091878 Jun 24
> > 09:44:01 (none) kernel: [67593.322977] R13: ffff888267b2be00 R14:
> > 0000000000000000 R15: 00003d79cbfb62b3 Jun 24 09:44:01 (none) kernel:
> > [67593.322980]  do_idle+0x1d6/0x230 Jun 24 09:44:01 (none) kernel:
> [67593.322983]  cpu_startup_entry+0x6a/0x70 Jun 24 09:44:01 (none) kernel=
:
> [67593.322985]  start_secondary+0x183/0x1b0 Jun 24 09:44:01 (none) kernel=
:
> [67593.322987]  secondary_startup_64+0xa4/0xb0 Jun 24 09:44:01 (none)
> kernel: [67593.322988] ---[ end trace 7155571a10d3a95a ]--- Jun 24 09:44:=
01
> (none) kernel: [67593.343772] ------------[ cut here ]------------ Jun 24=
 09:44:01
> (none) kernel: [67593.343782] WARNING: CPU: 2 PID: 0 at
> /home/buildroot/darthost_APC910_wl/kernel/linux-
> 4.19.237/net/core/skbuff.c:624 skb_release_head_state+0x55/0x60 Jun 24
> 09:44:01 (none) kernel: [67593.343783] Modules linked in: elo cc770_isa c=
c770
> can_dev can_raw can e1000e pl2303 usbserial ptp pps_core
> x86_pkg_temp_thermal
> > Jun 24 09:44:01 (none) kernel: [67593.343788] CPU: 2 PID: 0 Comm:
> swapper/2 Tainted: G        W         4.19.237_dev-tomoyo-ima #1
> > Jun 24 09:44:01 (none) kernel: [67593.343789] Hardware name: Bernecker
> > + Rainer  Industrie-Elektronik  APC910/TS170, BIOS W1.22 02/03/2022
> > Jun 24 09:44:01 (none) kernel: [67593.343791] RIP:
> > 0010:skb_release_head_state+0x55/0x60
> > Jun 24 09:44:01 (none) kernel: [67593.343793] Code: 81 e2 00 00 0f 00
> > 75 16 48 89 df 5b e9 a4 f9 31 00 5b c3 48 83 e7 fe e8 f9 ff 01 00 eb
> > ca 48 c7 c7 68 57 d8 81 e8 28 8e 0e 00 <0f> 0b 48 8b 43 60 eb d6 0f 1f
> > 00 53 48 89 fb e8 97 ff ff ff 48 83 Jun 24 09:44:01 (none) kernel:
> > [67593.343794] RSP: 0018:ffff888267b03e78 EFLAGS: 00010086 Jun 24
> > 09:44:01 (none) kernel: [67593.343795] RAX: 0000000000000024 RBX:
> > ffff8881fdc7e100 RCX: ffffffff82035638 Jun 24 09:44:01 (none) kernel:
> > [67593.343796] RDX: 0000000000000000 RSI: 0000000000000092 RDI:
> > ffffffff825587ac Jun 24 09:44:01 (none) kernel: [67593.343797] RBP:
> > 0000000000000000 R08: 0000000000e9931f R09: 0000000000000007 Jun 24
> > 09:44:01 (none) kernel: [67593.343798] R10: 0000000000000000 R11:
> > ffffffff8255a7ed R12: ffff888266a7e000 Jun 24 09:44:01 (none) kernel:
> > [67593.343799] R13: ffff888246313400 R14: ffff888266a7e000 R15:
> 0000000000000055 Jun 24 09:44:01 (none) kernel: [67593.343800] FS:
> 0000000000000000(0000) GS:ffff888267b00000(0000)
> knlGS:0000000000000000 Jun 24 09:44:01 (none) kernel: [67593.343801] CS:
> 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 Jun 24 09:44:01 (none) kerne=
l:
> [67593.343802] CR2: 00007f7fd9d60008 CR3: 000000000200a002 CR4:
> 00000000003606e0 Jun 24 09:44:01 (none) kernel: [67593.343803] DR0:
> 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 Jun 24
> 09:44:01 (none) kernel: [67593.343804] DR3: 0000000000000000 DR6:
> 00000000fffe0ff0 DR7: 0000000000000400 Jun 24 09:44:01 (none) kernel:
> [67593.343805] Call Trace:
> > Jun 24 09:44:01 (none) kernel: [67593.343806]  <IRQ> Jun 24 09:44:01
> > (none) kernel: [67593.343808]  skb_release_all+0x9/0x20 Jun 24
> > 09:44:01 (none) kernel: [67593.343810]  consume_skb+0x27/0x90 Jun 24
> > 09:44:01 (none) kernel: [67593.343812]  can_put_echo_skb+0xc5/0x120
> > [can_dev] Jun 24 09:44:01 (none) kernel: [67593.343814]
> > cc770_interrupt+0x220/0x600 [cc770] Jun 24 09:44:01 (none) kernel:
> > [67593.343816]  ? timerqueue_add+0x58/0x60 Jun 24 09:44:01 (none)
> > kernel: [67593.343819]  __handle_irq_event_percpu+0x41/0x1a0
> > Jun 24 09:44:01 (none) kernel: [67593.343821]
> > handle_irq_event_percpu+0x2b/0x70 Jun 24 09:44:01 (none) kernel:
> > [67593.343823]  handle_irq_event+0x22/0x40 Jun 24 09:44:01 (none)
> > kernel: [67593.343824]  handle_edge_irq+0x75/0x190 Jun 24 09:44:01
> > (none) kernel: [67593.343826]  handle_irq+0x17/0x20 Jun 24 09:44:01
> > (none) kernel: [67593.343827]  do_IRQ+0x3c/0xd0 Jun 24 09:44:01 (none)
> > kernel: [67593.343830]  common_interrupt+0xf/0xf Jun 24 09:44:01
> > (none) kernel: [67593.343831]  </IRQ> Jun 24 09:44:01 (none) kernel:
> > [67593.343833] RIP: 0010:cpuidle_enter_state+0xb2/0x310
> > Jun 24 09:44:01 (none) kernel: [67593.343835] Code: c3 8b 05 99 31 a4
> > 00 85 c0 0f 8f 33 01 00 00 31 ff e8 c2 06 9e ff 45 84 f6 0f 85 f1 00
> > 00 00 fb 48 ba cf f7 53 e3 a5 9b c4 20 <4c> 29 fb 48 89 d8 48 c1 fb 3f
> > 48 f7 ea b8 ff ff ff 7f 48 c1 fa 07 Jun 24 09:44:01 (none) kernel:
> > [67593.343836] RSP: 0018:ffffc900000a7e90 EFLAGS: 00000246 ORIG_RAX:
> > ffffffffffffffdc Jun 24 09:44:01 (none) kernel: [67593.343837] RAX:
> > ffff888267b24840 RBX: 00003d79cd3e5ff2 RCX: 000000000000001f Jun 24
> > 09:44:01 (none) kernel: [67593.343838] RDX: 20c49ba5e353f7cf RSI:
> > 000000002f32988b RDI: 0000000000000000 Jun 24 09:44:01 (none) kernel:
> > [67593.343839] RBP: 0000000000000002 R08: 0000000000000000 R09:
> > 0000000000024100 Jun 24 09:44:01 (none) kernel: [67593.343840] R10:
> > ffffc900000a7e78 R11: 0000000000003d3d R12: ffffffff82091638 Jun 24
> > 09:44:01 (none) kernel: [67593.343841] R13: ffff888267b2be00 R14:
> > 0000000000000000 R15: 00003d79cd385aa1 Jun 24 09:44:01 (none) kernel:
> > [67593.343844]  do_idle+0x1d6/0x230 Jun 24 09:44:01 (none) kernel:
> [67593.343846]  cpu_startup_entry+0x6a/0x70 Jun 24 09:44:01 (none) kernel=
:
> [67593.343848]  start_secondary+0x183/0x1b0 Jun 24 09:44:01 (none) kernel=
:
> [67593.343849]  secondary_startup_64+0xa4/0xb0 Jun 24 09:44:01 (none)
> kernel: [67593.343851] ---[ end trace 7155571a10d3a95b ]--- Jun 24 09:44:=
02
> (none) kernel: [67593.345557] ------------[ cut here ]------------ Jun 24=
 09:44:02
> (none) kernel: [67593.345566] WARNING: CPU: 2 PID: 0 at
> /home/buildroot/darthost_APC910_wl/kernel/linux-
> 4.19.237/net/core/skbuff.c:624 skb_release_head_state+0x55/0x60 Jun 24
> 09:44:02 (none) kernel: [67593.345567] Modules linked in: elo cc770_isa c=
c770
> can_dev can_raw can e1000e pl2303 usbserial ptp pps_core
> x86_pkg_temp_thermal
> > Jun 24 09:44:02 (none) kernel: [67593.345571] CPU: 2 PID: 0 Comm:
> swapper/2 Tainted: G        W         4.19.237_dev-tomoyo-ima #1
> > Jun 24 09:44:02 (none) kernel: [67593.345572] Hardware name: Bernecker
> > + Rainer  Industrie-Elektronik  APC910/TS170, BIOS W1.22 02/03/2022
> > Jun 24 09:44:02 (none) kernel: [67593.345574] RIP:
> > 0010:skb_release_head_state+0x55/0x60
> > Jun 24 09:44:02 (none) kernel: [67593.345576] Code: 81 e2 00 00 0f 00
> > 75 16 48 89 df 5b e9 a4 f9 31 00 5b c3 48 83 e7 fe e8 f9 ff 01 00 eb
> > ca 48 c7 c7 68 57 d8 81 e8 28 8e 0e 00 <0f> 0b 48 8b 43 60 eb d6 0f 1f
> > 00 53 48 89 fb e8 97 ff ff ff 48 83 Jun 24 09:44:02 (none) kernel:
> > [67593.345577] RSP: 0018:ffff888267b03e78 EFLAGS: 00010086 Jun 24
> > 09:44:02 (none) kernel: [67593.345578] RAX: 0000000000000024 RBX:
> > ffff888246313400 RCX: ffffffff82035638 Jun 24 09:44:02 (none) kernel:
> > [67593.345579] RDX: 0000000000000000 RSI: 0000000000000092 RDI:
> > ffffffff825587ac Jun 24 09:44:02 (none) kernel: [67593.345580] RBP:
> > 0000000000000000 R08: 0000000000e9934d R09: 0000000000000007 Jun 24
> > 09:44:02 (none) kernel: [67593.345581] R10: 0000000000000000 R11:
> > ffffffff8255a7ed R12: ffff888266a7e000 Jun 24 09:44:02 (none) kernel:
> > [67593.345582] R13: ffff888246313100 R14: ffff888266a7e000 R15:
> 0000000000000055 Jun 24 09:44:02 (none) kernel: [67593.345583] FS:
> 0000000000000000(0000) GS:ffff888267b00000(0000)
> knlGS:0000000000000000 Jun 24 09:44:02 (none) kernel: [67593.345584] CS:
> 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 Jun 24 09:44:02 (none) kerne=
l:
> [67593.345585] CR2: 00007f7fd9d60008 CR3: 000000000200a002 CR4:
> 00000000003606e0 Jun 24 09:44:02 (none) kernel: [67593.345586] DR0:
> 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 Jun 24
> 09:44:02 (none) kernel: [67593.345587] DR3: 0000000000000000 DR6:
> 00000000fffe0ff0 DR7: 0000000000000400 Jun 24 09:44:02 (none) kernel:
> [67593.345588] Call Trace:
> > Jun 24 09:44:02 (none) kernel: [67593.345589]  <IRQ> Jun 24 09:44:02
> > (none) kernel: [67593.345591]  skb_release_all+0x9/0x20 Jun 24
> > 09:44:02 (none) kernel: [67593.345593]  consume_skb+0x27/0x90 Jun 24
> > 09:44:02 (none) kernel: [67593.345595]  can_put_echo_skb+0xc5/0x120
> > [can_dev] Jun 24 09:44:02 (none) kernel: [67593.345597]
> > cc770_interrupt+0x220/0x600 [cc770] Jun 24 09:44:02 (none) kernel:
> > [67593.345599]  ? timerqueue_add+0x58/0x60 Jun 24 09:44:02 (none)
> > kernel: [67593.345601]  __handle_irq_event_percpu+0x41/0x1a0
> > Jun 24 09:44:02 (none) kernel: [67593.345603]
> > handle_irq_event_percpu+0x2b/0x70 Jun 24 09:44:02 (none) kernel:
> > [67593.345605]  handle_irq_event+0x22/0x40 Jun 24 09:44:02 (none)
> > kernel: [67593.345607]  handle_edge_irq+0x75/0x190 Jun 24 09:44:02
> > (none) kernel: [67593.345608]  handle_irq+0x17/0x20 Jun 24 09:44:02
> > (none) kernel: [67593.345609]  do_IRQ+0x3c/0xd0 Jun 24 09:44:02 (none)
> > kernel: [67593.345612]  common_interrupt+0xf/0xf Jun 24 09:44:02
> > (none) kernel: [67593.345613]  </IRQ> Jun 24 09:44:02 (none) kernel:
> > [67593.345615] RIP: 0010:cpuidle_enter_state+0xb2/0x310
> > Jun 24 09:44:02 (none) kernel: [67593.345616] Code: c3 8b 05 99 31 a4
> > 00 85 c0 0f 8f 33 01 00 00 31 ff e8 c2 06 9e ff 45 84 f6 0f 85 f1 00
> > 00 00 fb 48 ba cf f7 53 e3 a5 9b c4 20 <4c> 29 fb 48 89 d8 48 c1 fb 3f
> > 48 f7 ea b8 ff ff ff 7f 48 c1 fa 07 Jun 24 09:44:02 (none) kernel:
> > [67593.345617] RSP: 0018:ffffc900000a7e90 EFLAGS: 00000246 ORIG_RAX:
> > ffffffffffffffdc Jun 24 09:44:02 (none) kernel: [67593.345619] RAX:
> > ffff888267b24840 RBX: 00003d79cd595186 RCX: 000000000000001f Jun 24
> > 09:44:02 (none) kernel: [67593.345619] RDX: 20c49ba5e353f7cf RSI:
> > 000000002f32988b RDI: 0000000000000000 Jun 24 09:44:02 (none) kernel:
> > [67593.345620] RBP: 0000000000000006 R08: 0000000000000000 R09:
> > 0000000000024100 Jun 24 09:44:02 (none) kernel: [67593.345621] R10:
> > ffffc900000a7e78 R11: 0000000000000225 R12: ffffffff820917b8 Jun 24
> > 09:44:02 (none) kernel: [67593.345622] R13: ffff888267b2be00 R14:
> 0000000000000000 R15: 00003d79cd56dc90 Jun 24 09:44:02 (none) kernel:
> [67593.345625]  do_idle+0x1d6/0x230 Jun 24 09:44:02 (none) kernel:
> [67593.345627]  cpu_startup_entry+0x6a/0x70 Jun 24 09:44:02 (none) kernel=
:
> [67593.345629]  start_secondary+0x183/0x1b0 Jun 24 09:44:02 (none) kernel=
:
> [67593.345631]  secondary_startup_64+0xa4/0xb0 Jun 24 09:44:02 (none)
> kernel: [67593.345632] ---[ end trace 7155571a10d3a95c ]--- ...
>
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       |
> https://eur03.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=3D05%7C01%7Cmichael.kaesbauer%40krones.c
> om%7Cb8b9fb05e6c54bd3799608da696d4470%7C1dd2af3850fb445c87604bd9
> 48765fc7%7C0%7C0%7C637938215277521352%7CUnknown%7CTWFpbGZsb3
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C3000%7C%7C%7C&amp;sdata=3D7GqeWhtOgVfXxF3jFrGyp404YUxLdy
> yMwZBPYALg6KE%3D&amp;reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

Kind regards
Michael

[https://www.krones.com/ext/mailbanner/drinktec/Krones_Linie_Mann.jpg] <htt=
ps://www.krones.com/drinktec> _____________________________________________=
_________________

Krones AG
Vorstand: Christoph Klenk, Vorstandsvorsitzender,
Norbert Broger, Thomas Ricker, Markus Tischer, Ralf Goldbrunner
Vorsitzender des Aufsichtsrats: Volker Kronseder
Registergericht: Regensburg HRB 23 44, Umsatzsteuer-ID-Nummer: DE 133 695 9=
99

______________________________________________________________

Der Inhalt dieser E-Mail und jeder Anhang ist vertraulich.
Diese Inhalte sind nur fuer die benannten Adressaten.
Wenn Sie diese E-Mail durch einen Fehler erhalten haben,
benachrichtigen Sie sofort Ihren Administrator oder den Absender.
Behandeln Sie die E-Mail vertraulich.

* Diese E-Mail wurde auf Viren und gefaehrlichen Inhalt geprueft. *

______________________________________________________________

The contents of this email and any attachments are confidential.
They are intended for the named recipient(s) only.
If you have received this email in error please notify the system manager
or the sender immediately and do not disclose the contents to anyone or
make copies.

* This e-Mail was scanned for viruses, vandals and malicious content. *
