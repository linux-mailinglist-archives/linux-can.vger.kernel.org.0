Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCBE3F76A7
	for <lists+linux-can@lfdr.de>; Wed, 25 Aug 2021 15:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhHYNz7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Aug 2021 09:55:59 -0400
Received: from mail-eopbgr130071.outbound.protection.outlook.com ([40.107.13.71]:36830
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229760AbhHYNz6 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 25 Aug 2021 09:55:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcOaCy5orzo4LDrk+JMj3mMwy3YHu2yBVQIWa2aOfMBwtEB9D5XdQ/YOORNg/xkKmrQ3freAzKnF6qRKf0jhLe3nGLSD1Oh+Wv31roKk6ocdss/+8WnsSYMMbD6n5+6QDaSazdNOlvS08jV8rDW9AU6cXM60ivaTRgP8Rz6hfpCBQE30AWSvYkdGMnmjjo0GOynXpyJoYzv5fAfelpyXbABQTLqAhFA4AX5o/eLpUbmuuOGY43XbCHWunrPJgPlYnW8jOKmjV8aiGZPioFFv7TTL5a2IJcbdeeEs4liJO7j/YGYcWtQBJWxcAcqbkXUsQAKcVAPAWgRifK405s+4QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDAP/m2/FBgqbMyQuKFgj5yiCVJrInrwznw0NwUq34s=;
 b=BJK/cAaKJuu5mnihtv55Y6ECVzX44YJSx1hKNDa5okhGuAKJvDP8Av8N4sKFsXxjLoBmwc1d3iP6d4i91bONCZFsAz1rQWQIiKwABQUBclI6ovjyaHGx4q5BjI+aR1vZsH+ljwtyi/vVSgfXzrP73LuMBOwtu4o+BBzR4TPds2KZuGSO970P/hu/TzCnk6LTeVm/6GkNwB486ao/i7m91NrOqbJMWcmRETVhCoLRLep/J5jQYAf/0IU1jxX1UEyjUSudEsc8bSylpLPe1qzQ2EnEZN3unCaAMvyGC0PMKdXDYJQ0CJQ1StZM4zk8xC8N6tNs9zZyI+L0wgrKELaQDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDAP/m2/FBgqbMyQuKFgj5yiCVJrInrwznw0NwUq34s=;
 b=2zK2J8HIiq2zN3bvK8gwzfw1Hk0H4SM1ADLbr4MdkfjIxhTCOxKH+3U9T/+yHIaDwV5XXAudwIaLaZn21PwFFnAnvKT575tUOoFpLGcAcZMLMeOTLgE+e48REgBlW1hNepQzBkUeYJk4pGBn+0nJfKKHkDlJpYDoqsYbGDopxjM=
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com (2603:10a6:102:f1::9)
 by PA4PR03MB6784.eurprd03.prod.outlook.com (2603:10a6:102:f0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Wed, 25 Aug
 2021 13:55:09 +0000
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::801f:180b:472f:3cfb]) by PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::801f:180b:472f:3cfb%3]) with mapi id 15.20.4436.025; Wed, 25 Aug 2021
 13:55:08 +0000
From:   =?Windows-1252?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: TR: pull-request: can-next 2021-07-25
Thread-Topic: pull-request: can-next 2021-07-25
Thread-Index: AQHXgig21t8KNA3ptEaoOkqrvGPhaatVw7qAgC6kzWw=
Date:   Wed, 25 Aug 2021 13:55:08 +0000
Message-ID: <PA4PR03MB6797385C06D695452B79513BD6C69@PA4PR03MB6797.eurprd03.prod.outlook.com>
References: <20210726141144.862529-1-mkl@pengutronix.de>
 <162733441301.18684.10819552730140170023.git-patchwork-notify@kernel.org>
In-Reply-To: <162733441301.18684.10819552730140170023.git-patchwork-notify@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=peak-system.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 208b0e6f-9626-449b-4499-08d967cff364
x-ms-traffictypediagnostic: PA4PR03MB6784:
x-microsoft-antispam-prvs: <PA4PR03MB678458F0789B565D4595CC58D6C69@PA4PR03MB6784.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PRMzLK4CMt69VwKFSEbX5MC88Z7fidZWa7jxsOyig4LYW2cxe3tOgMjLHU7xGsPg1AzTYbSZoSra7BnQ1rpk5zm0YtkThFsuFpFCCWdgzVqb5mQBo6Xod/U2TsvdNJk481xtQwttJce6JBL3g9Xq4JRXH/mSz6K1aQMlioQhttC7q5W97kzEx/LlijQib+NosE1MwE3rFSpmlhXG2JqROh+VUeFEx7ANgzcUgmeBUMR1MJYI84QAMxb6WPtwbgMFWwaTrNE2GC/W3fA9WI5tOcw+dNmrsQggljMuA/y2JINZfR/IEnzvsDUEOcyoJaQwoJ7tP70nLGTnl2bz9ZI30Vf5XADEaLa7fXRWiyBrPK9umSDpot2hHGniSLsSuaLOn+5AiPXbfX7khKsrKePOJhn3d1JFUkatLXSmnPgCz45fI4CytPYxTPvafrvuDNhvXj/gd6D3g4Q6LhrVfX0WjreW70LY/MeAukcGrFpp4dlTR2xjROz5HmT28J/SujPLzv6VFl8IHeGVG1kiyibch4XVl4TFv0ePy44YGjp2KSMsTwvkvnVUMThSJEsXIwEfrdSQubhkkrPAhDU7lUYR1a83X7uG+04ALORkloog4LROItA2mlACNaJ63ZxpfmF8nfJ0MJ60N/6LqsDTXI51H5FBNtiOyGpgh+Thon+scCK6RH8nXrBU+TIWKVE6lJ9fvYhd7fGJLSF+xUaNFrcKuxLa2FJ5GU4eHxZEZeOng/CV7+D5cmNK04m1GB1QfBBk4khW2HbNGI3R2IMDpPUaPPfQhHVIQ5VeazfZkR917Yg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB6797.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39840400004)(346002)(376002)(396003)(366004)(4326008)(15974865002)(76116006)(52536014)(66476007)(66556008)(66446008)(2906002)(64756008)(66946007)(316002)(9686003)(5660300002)(33656002)(71200400001)(6916009)(966005)(26005)(122000001)(86362001)(38100700002)(6506007)(186003)(508600001)(38070700005)(8936002)(83380400001)(55016002)(66574015)(7696005)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?PbZ4waihZ0WN5EsDPH6seVeiAdbO0c0LNdEADfGOozxPePBo3H/JMxUm?=
 =?Windows-1252?Q?/dbK8cpCr90jeLcYVjIT9YhzUEy6XqzYcBKFTix3+651NU8fTEam7A0n?=
 =?Windows-1252?Q?d4FfEPMRVJqk2aeAWA8saF7Iq1DXzo9q1rVP3e72mmD0fwbaU1gkr24v?=
 =?Windows-1252?Q?uAiXUkFJA/Or2qzykNz1LF52T4fwVh/u44yxoAW34FEvS465sxRZvhmj?=
 =?Windows-1252?Q?sHb/RA3zmxfgYjuS6csQUqEQ+fpJgVHzEEinWdpHJPu35FubNohJZj7j?=
 =?Windows-1252?Q?r+xxJBoUMLk6Z9xnPYcMGF5YjP83KvMuJMMOhE3ppQ/oTp40npBH0pMy?=
 =?Windows-1252?Q?fqoR2yTY35tROsNMHxmFFATQxsP/wHx4ioanMzEoDJcOdtsWcu8BGAvA?=
 =?Windows-1252?Q?hfs0eVCPg1Rm/e25+CB2hSZ4TNoN2TK4NPly6YxE5YGnDi0UpdEgmtnn?=
 =?Windows-1252?Q?baZ4tHmYWLGtkiFPiHmgYl6YVZiuY9+mzeKTUEog1FFtfV4t364TKiWY?=
 =?Windows-1252?Q?PMEFaTTkPZewCxOVOJt2h+75Lmwl27+VPphxtehY7sNqwogsfgk9rZpw?=
 =?Windows-1252?Q?nGmAw4r35g45FiO+qnQt8lcOf2mY/ndWUAX5LJGIA19ZRGTsJdmdt7BG?=
 =?Windows-1252?Q?NYUxEVUKH8Q2bBwPRrVwdh17jaiSrgp+ic86Tx0LdKZfWcZqc3ekN6S+?=
 =?Windows-1252?Q?RdBXIxpQfxsz7Ec9Q4KwaBNVMA3KdYiIfrIKGVD5zAmrxOYIGWK725n3?=
 =?Windows-1252?Q?49eKexrEYa5AHgV/fWu5Y1toPxmPGaCudHj6wfx/CQ3lRnVn+ysYhz/R?=
 =?Windows-1252?Q?1xYZUpgEg9Uks/br9k/U/6kwI3aKsegJbZ6O50/aelLhcNrZKpGf7ksT?=
 =?Windows-1252?Q?ZSYU5QeRb1Oz78iwTU8sGK9TDqfPnPAB2Qv0HCU03j+ovwpZPjATi9IS?=
 =?Windows-1252?Q?emAJNYMJgnVkRJl6/vlBNHRttAYFNvCikVw66DrAqJT/g92Tc3PU/yez?=
 =?Windows-1252?Q?6gqE2SBB5SDdmEle2HcI11pt4YVRVu1gz+JfvKHWJhnxAhDPPpqfaOwh?=
 =?Windows-1252?Q?QVEw7H/o6BWIOr9eetSvQYUX0h19tdIVGIrQ1j3GWC2qYsBm7N7gWHNt?=
 =?Windows-1252?Q?dV9J9hYUfnVRTlHEM0PG79qRHu1oKIF+xB6y3dVmadzrtEOfv7Rtf3Yq?=
 =?Windows-1252?Q?5RSYRtPt0wQQq42tFUTHOD8MbAfc8F1/kGswuHpDfdaYjBo61RTuQh3X?=
 =?Windows-1252?Q?OHbUPL8zw3Y5cDA2aIBB2pTl0BrP8tKnaA/6nJgrbXaKq5bZC/SY7qND?=
 =?Windows-1252?Q?ZTgzQ0EGdx7D0xI0Cnl7c7ezwyJ8J05Q/2CPzCxfrfvIBOUe9Fy+S3/1?=
 =?Windows-1252?Q?r1x/DEQP4ux05oVgXkHo1WZ40LMOBdwrtm/MEg2oTe/Uj0OYN0a7CNam?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB6797.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208b0e6f-9626-449b-4499-08d967cff364
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 13:55:08.7667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PKH4oc7JpLRn7AMbq63mNo/8/x8fK/CBcQYwAB+2ckKkty952yprZ+KpkgwqhmjkCzkNyAOmuDKIUnBgSJBHZ4bjqsw7pJOGJ88rgLhAU8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6784
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc,

AFAIK I don't see any of the peak_* patches below appearing in linux for al=
l this time... Any idea?

Regards,

=97 St=E9phane

De : patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org=
>
Envoy=E9 : lundi 26 juillet 2021 23:20
=C0 : Marc Kleine-Budde <mkl@pengutronix.de>
Cc : netdev@vger.kernel.org <netdev@vger.kernel.org>; davem@davemloft.net <=
davem@davemloft.net>; kuba@kernel.org <kuba@kernel.org>; linux-can@vger.ker=
nel.org <linux-can@vger.kernel.org>; kernel@pengutronix.de <kernel@pengutro=
nix.de>
Objet : Re: pull-request: can-next 2021-07-25

Hello:

This pull request was applied to netdev/net-next.git (refs/heads/master):

On Mon, 26 Jul 2021 16:10:58 +0200 you wrote:
> Hello Jakub, hello David,
>
> this is a pull request of 46 patches for net-next/master.
>
> The first 6 patches target the CAN J1939 protocol. One is from
> gushengxian, fixing a grammatical error, 5 are by me fixing a checkpatch
> warning, make use of the fallthrough pseudo-keyword, and use
> consistent variable naming.
>
> [...]

Here is the summary with links:
  - pull-request: can-next 2021-07-25
    https://git.kernel.org/netdev/net-next/c/d20e5880fe9d
  - [net-next,02/46] can: j1939: fix checkpatch warnings
    https://git.kernel.org/netdev/net-next/c/333128737955
  - [net-next,03/46] can: j1939: replace fall through comment by fallthroug=
h pseudo-keyword
    https://git.kernel.org/netdev/net-next/c/641ba6ded234
  - [net-next,04/46] can: j1939: j1939_session_completed(): use consistent =
name se_skb for the session skb
    https://git.kernel.org/netdev/net-next/c/7ac56e40d054
  - [net-next,05/46] can: j1939: j1939_session_tx_dat(): use consistent nam=
e se_skcb for session skb control buffer
    https://git.kernel.org/netdev/net-next/c/78b77c760f71
  - [net-next,06/46] can: j1939: j1939_xtp_rx_dat_one(): use separate point=
er for session skb control buffer
    https://git.kernel.org/netdev/net-next/c/a08ec5fe709f
  - [net-next,07/46] can: rx-offload: add skb queue for use during ISR
    https://git.kernel.org/netdev/net-next/c/c757096ea103
  - [net-next,08/46] can: rx-offload: can_rx_offload_irq_finish(): directly=
 call napi_schedule()
    https://git.kernel.org/netdev/net-next/c/1e0d8e507ea4
  - [net-next,09/46] can: rx-offload: can_rx_offload_threaded_irq_finish():=
 add new function to be called from threaded interrupt
    https://git.kernel.org/netdev/net-next/c/30bfec4fec59
  - [net-next,10/46] can: bittiming: fix documentation for struct can_tdc
    https://git.kernel.org/netdev/net-next/c/8345a3307381
  - [net-next,11/46] can: netlink: clear data_bittiming if FD is turned off
    https://git.kernel.org/netdev/net-next/c/e3b0a4a47064
  - [net-next,12/46] can: netlink: remove redundant check in can_validate()
    https://git.kernel.org/netdev/net-next/c/6b6bd1999267
  - [net-next,13/46] dt-bindings: net: can: Document transceiver implementa=
tion as phy
    https://git.kernel.org/netdev/net-next/c/9c0e7ccd831b
  - [net-next,14/46] can: m_can: Add support for transceiver as phy
    https://git.kernel.org/netdev/net-next/c/d836cb5fe045
  - [net-next,15/46] can: m_can: use devm_platform_ioremap_resource_byname
    https://git.kernel.org/netdev/net-next/c/9808dba1bbcb
  - [net-next,16/46] can: m_can: remove support for custom bit timing
    https://git.kernel.org/netdev/net-next/c/0ddd83fbebbc
  - [net-next,17/46] can: mcp251xfd: mcp251xfd_probe(): try to get crystal =
clock rate from property
    https://git.kernel.org/netdev/net-next/c/74f89cf17e44
  - [net-next,18/46] can: mcp251xfd: Fix header block to clarify independen=
ce from OF
    https://git.kernel.org/netdev/net-next/c/71520f85f908
  - [net-next,19/46] can: mcp251xfd: mcp251xfd_open(): request IRQ as share=
d
    https://git.kernel.org/netdev/net-next/c/cb6adfe27680
  - [net-next,20/46] can: esd_usb2: use DEVICE_ATTR_RO() helper macro
    https://git.kernel.org/netdev/net-next/c/681e4a764521
  - [net-next,21/46] can: janz-ican3: use DEVICE_ATTR_RO/RW() helper macro
    https://git.kernel.org/netdev/net-next/c/f731707c5667
  - [net-next,22/46] can: at91_can: use DEVICE_ATTR_RW() helper macro
    https://git.kernel.org/netdev/net-next/c/42b9fd6ec7c9
  - [net-next,23/46] net: at91_can: remove redundant blank lines
    https://git.kernel.org/netdev/net-next/c/822a99c41fb4
  - [net-next,24/46] net: at91_can: add blank line after declarations
    https://git.kernel.org/netdev/net-next/c/933850c4b912
  - [net-next,25/46] net: at91_can: fix the code style issue about macro
    https://git.kernel.org/netdev/net-next/c/57bca980bad4
  - [net-next,26/46] net: at91_can: use BIT macro
    https://git.kernel.org/netdev/net-next/c/8ed1661cf21e
  - [net-next,27/46] net: at91_can: fix the alignment issue
    https://git.kernel.org/netdev/net-next/c/ccc5f1c994df
  - [net-next,28/46] net: at91_can: add braces {} to all arms of the statem=
ent
    https://git.kernel.org/netdev/net-next/c/02400533bb70
  - [net-next,29/46] net: at91_can: remove redundant space
    https://git.kernel.org/netdev/net-next/c/fc1d97d4fbfd
  - [net-next,30/46] net: at91_can: fix the comments style issue
    https://git.kernel.org/netdev/net-next/c/5bbe60493a21
  - [net-next,31/46] can: peak_pci: convert comments to network style comme=
nts
    https://git.kernel.org/netdev/net-next/c/9b69aff9fd1a
  - [net-next,32/46] can: peak_pci: fix checkpatch warnings
    https://git.kernel.org/netdev/net-next/c/fe1fa1387a15
  - [net-next,33/46] can: peak_pci: Add name and FW version of the card in =
kernel buffer
    https://git.kernel.org/netdev/net-next/c/805ff68c8e7f
  - [net-next,34/46] can: peak_usb: pcan_usb_get_device_id(): read value on=
ly in case of success
    https://git.kernel.org/netdev/net-next/c/1d0214a0f5db
  - [net-next,35/46] can: peak_usb: PCAN-USB: add support of loopback and o=
ne-shot mode
    https://git.kernel.org/netdev/net-next/c/3a7939495ce8
  - [net-next,36/46] can: peak_usb: pcan_usb_encode_msg(): add information
    https://git.kernel.org/netdev/net-next/c/1763c547648d
  - [net-next,37/46] can: peak_usb: pcan_usb_decode_error(): upgrade handli=
ng of bus state changes
    https://git.kernel.org/netdev/net-next/c/c11dcee75830
  - [net-next,38/46] can: etas_es58x: fix three typos in author name and do=
cumentation
    https://git.kernel.org/netdev/net-next/c/58fb92a517b5
  - [net-next,39/46] can: etas_es58x: use error pointer during device probi=
ng
    https://git.kernel.org/netdev/net-next/c/45cb13963df3
  - [net-next,40/46] can: etas_es58x: use devm_kzalloc() to allocate device=
 resources
    https://git.kernel.org/netdev/net-next/c/6bde4c7fd845
  - [net-next,41/46] can: etas_es58x: add es58x_free_netdevs() to factorize=
 code
    https://git.kernel.org/netdev/net-next/c/004653f0abf2
  - [net-next,42/46] can: etas_es58x: use sizeof and sizeof_field macros in=
stead of constant values
    https://git.kernel.org/netdev/net-next/c/7fcecf51c18f
  - [net-next,43/46] can: etas_es58x: rewrite the message cast in es58{1,_f=
d}_tx_can_msg to increase readability
    https://git.kernel.org/netdev/net-next/c/f4f5247daa45
  - [net-next,44/46] can: flexcan: add platform data header
    https://git.kernel.org/netdev/net-next/c/896e7f3e7424
  - [net-next,45/46] can: flexcan: add mcf5441x support
    https://git.kernel.org/netdev/net-next/c/d9cead75b1c6
  - [net-next,46/46] can: flexcan: update Kconfig to enable coldfire
    https://git.kernel.org/netdev/net-next/c/8dad5561c13a

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
Unsere Datenschutzerklaerung mit wichtigen Hinweisen
zur Behandlung personenbezogener Daten finden Sie unter
www.peak-system.com/Datenschutz.483.0.html
