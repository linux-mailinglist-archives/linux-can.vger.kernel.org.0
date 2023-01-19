Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C8B6739AD
	for <lists+linux-can@lfdr.de>; Thu, 19 Jan 2023 14:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjASNNI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Jan 2023 08:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjASNMi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2023 08:12:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87B17D66F
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 05:11:13 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pIUhE-0004bm-0k
        for linux-can@vger.kernel.org; Thu, 19 Jan 2023 14:11:12 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:7961:17f5:9ae5:1a41])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 78DCB15D3B2
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 13:11:11 +0000 (UTC)
Received: from bjornoya.blackshift.org
        by bjornoya with LMTP
        id Q4+YJiM8yWMt6g0As6a69A
        (envelope-from <Stefan.Althoefer@janztec.com>)
        for <mkl-all@blackshift.org>; Thu, 19 Jan 2023 12:48:35 +0000
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 763FE15D34C
        for <mkl-all@blackshift.org>; Thu, 19 Jan 2023 12:48:35 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 22F8215D34B
        for <ptx@kleine-budde.de>; Thu, 19 Jan 2023 12:48:35 +0000 (UTC)
Received: from mail-be0deu01on2042.outbound.protection.outlook.com ([40.107.127.42] helo=DEU01-BE0-obe.outbound.protection.outlook.com)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <Stefan.Althoefer@janztec.com>)
        id 1pIULI-0007sS-Cl
        for mkl@pengutronix.de; Thu, 19 Jan 2023 13:48:33 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPLg+U3J10ZlHJXmjckg3QVqLelgtdyWxchci1g7cWCMxVsbDIzGOWEpOhJA3sQw4YAVNs0l7fNMhLThjeY/I2CeA+6jPKpsErwd1rquVGobyOL2XJeJMgAOiUMXyHRF7sA0yWbm4Rb2J3Y2CiggRehXeyZSb4F8Xum3aoCwt6P/mTcXf/6INyUMsh+Ysez0qpPFT3xxbznX0M5rs2r9MJVoi79hDx6BTMWEMUVJfvwqyJ7t8Lr86ovX5vYgMb3fFNBV4BT30YzBByDCQ15ExzQsgyMqDahVrTelk1fMqbpBj5dXkKka3oZK/IxVY5l0wLVcLKWrYQzBaJGMo7DF+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vR1gZLxEcCpNhZRmYURUhbfHiZJA6NiteG3t089pwFM=;
 b=VVLPS7INSR2mM06Qg032TVYT3jkS0PY9N5fq6MwRz4CH1CoeGEp8vLOygmhi14uBragg7xjUnwpXT53eGHxa2kx6ID4HG+5ZefcnXvY8iwv8SppeQNNt/rICfdj4vsuu9qn/auSwkgkJt4/yrWjOQ9rWC7/JKENRaod1oNOY4ieYHfysalgIIjwe/q1n/KKKrhfq3uVKBweYHsl7y4j4I6UZROvChB6nxxFSRgMWvlJ1kUfxsOirJ209KPKkA28qJr0LQR9jRRl7JLWve0zGe3pdE/av3LyPM3PSN4+s7O8NAGexb6onmvj9I2mzeAZMM9TBiLBb89908incvS0+OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=janztec.com; dmarc=pass action=none header.from=janztec.com;
 dkim=pass header.d=janztec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janzag.onmicrosoft.de;
 s=selector1-janzag-onmicrosoft-de;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vR1gZLxEcCpNhZRmYURUhbfHiZJA6NiteG3t089pwFM=;
 b=eVoO2wRgY50X+g0FZb6tGMSNmvdRIvmQZC+KqIzzNZLywuReP0cA8UnhkvOajg9GcRk2MMmt/3jHfThgBiDqibqnYMX6MBs7f0l1Uh7HI95HMjluRcoGG+pY49tyyDVjZh2r9F76s6QpN00yrAywH4e/FLRqMKXzWd2iKDCtgEs=
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:26::13)
 by FR2P281MB1639.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 12:48:28 +0000
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d76a:8be5:c810:d1ba]) by FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d76a:8be5:c810:d1ba%6]) with mapi id 15.20.6002.025; Thu, 19 Jan 2023
 12:48:28 +0000
From:   =?iso-8859-1?Q?Stefan_Alth=F6fer?= <Stefan.Althoefer@janztec.com>
To:     "Thomas.Kopp@microchip.com" <Thomas.Kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
Thread-Topic: mcp251xfd: rx frame truncation (1/2)
Thread-Index: AQHZKzjliniR2Rjet0qunKK2mAziB66kQAkAgAATQtCAARGHgIAAD7xXgAA3PL0=
Date:   Thu, 19 Jan 2023 12:48:28 +0000
Message-ID: <FR0P281MB196633E4F8E1195086E2402B97C49@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
References: <FR0P281MB1966C774C1ED0752CCD6B80497C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966F32AD422DDD867F8C53A97C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB6484911640CCC738ED799E6FFBC79@BL3PR11MB6484.namprd11.prod.outlook.com>
 <FR0P281MB19663A60B0F7CE7F684A7A6297C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB64842584529FAEF279F7B137FBC49@BL3PR11MB6484.namprd11.prod.outlook.com>
 <FR0P281MB19669083201C1B9C2DFB9E5497C49@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR0P281MB19669083201C1B9C2DFB9E5497C49@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=janztec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB1966:EE_|FR2P281MB1639:EE_
x-ms-office365-filtering-correlation-id: c21210d0-4d90-480f-e64a-08dafa1b7699
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lTvBtfRCXgIYEZfFxRd4jMcA0u4ATX7cIaoUa+RukxytXRA1FAy72WjizVpMHs7Bggr5iF+x4vIE7addu43isddCsBil1XuOfdciONLh1DnvF9edcaklwRDHEIqrIEodbAg+vbqfeaVE/gnjBx+0UnyPcFycT/WdS6e6X4dVi/zOZJP4cq01nli5aK2DJyOBDebkg4cCb+WGHK0yJ1KTE+6PH+QkXL0ps+eKPStGCY1/cETLSdqmQBlQpfTujb7xKfOf7SHjDk4o/q7xAvzPbfmJZyLjmDeH0z7EbwrHZM8fwmPCNnyRG3Kx+8z5HBldkmyMoOHTxFBCz7njEuPCIzmYwMlUy8GiPVskbjOXD/LrAXFn07yoLJTix5xmYMH1VCzbOgbN49QbWp7EtLzLpFzlp2j/UpUA3cR3sMMlEWQ8c/TRWI7f+d4dIwDzJmevIsdDuaqBtECq5RwQNkb9x/Lag3xwYaaSNFsUH9mffR3/LSLZfd1KPH0+zotHMry4XiYjMkyEnmP3fxLZe5rJj0xXS9GSiXn4LIFaAj6ikWGjJC3Ev5LAoEE44/jt/eeRL2j8uBk5zWBuPdKiY15tFNHi/4M2e3BvyCv/L2OJCJMl7lIvXeE2Y/mJBtF/hwRBUM0HJjmzGZahAUT5SLxv3MKLglDhttsx80D4K3a+yApaeTuunZS+kBITvjmfE4gZH6SpP8I3aAWmTyDaMuuV9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(39830400003)(346002)(136003)(451199015)(122000001)(55016003)(38100700002)(38070700005)(52536014)(66446008)(8676002)(64756008)(5660300002)(76116006)(8936002)(66946007)(41300700001)(66476007)(66556008)(86362001)(2906002)(478600001)(110136005)(186003)(71200400001)(9686003)(7696005)(26005)(316002)(2940100002)(19627405001)(83380400001)(33656002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ih76BP6mJJZUiuV0PHsR57qHsCQoW1aDid+Bcc/jipn2e9m5wLUhDL2KBj?=
 =?iso-8859-1?Q?oqNulkFgksYtO539lzr0deZc/o2/lfm7hY5r9r7JjPVTSLRLdT6s2IexML?=
 =?iso-8859-1?Q?M5nLyn19JNlqzsbrfX3ZxoAT3AqejUbdk9t/kYlLutcaG/mnbtGWvXE3d9?=
 =?iso-8859-1?Q?5gg6wqMg5l5vuCOi68zrjMDDtcPf+NTI8SbxwchPOX+glAmYxTFyi6UW5v?=
 =?iso-8859-1?Q?yj4z4vj8cCs/6LmQpbxx9cRscyRO2AkOS5zi7N/xQc9L1Atrc3hVpGDGfb?=
 =?iso-8859-1?Q?8ZaX1Ef0yGtN9jci9ZuRl05Cz+VdjnKu+3ychu/kkE8K0dsN/CNdUmgJiR?=
 =?iso-8859-1?Q?wsYcJHGI+XEsJOwq9n04ZKKSI/JujNJOXRghzw0p7mTg4UN9/4S7ehPUiK?=
 =?iso-8859-1?Q?P+1KhZ1n1oMsImRMAI6PIj9lLXUv4Xh7D0Aro5fufwQ7pKboo0xAmo8ADV?=
 =?iso-8859-1?Q?Ug3eQMaJGs7Nn+mkAD+rym35ZGvsHSSYadBTcqr4xXC6/vNQ750rqdwEck?=
 =?iso-8859-1?Q?ZCz6qGnjtHNcg+fvIHKlDg0eWB/QtvZRZuFzDNWZqMA/Z7lR2mWSpgd0ag?=
 =?iso-8859-1?Q?s120dydQjPhQb0sI1wCdUpidYJAdKV+ZTWPYP/t7WPaZN7/EaxQaPwQzgo?=
 =?iso-8859-1?Q?N94eDaN5Y85ziWu12IFYjlnnqmxA59563fyBQ/Vqr6krtYgAGGdMmdwU91?=
 =?iso-8859-1?Q?pPPIZVbK10Peck2anuLF09ZuYXdPqMW1iLrIC5R6TSRi5mcpiP4OcUElmF?=
 =?iso-8859-1?Q?oB4C8pNJyCD+L5B0NCnwroV3bi54LPa761867RrppSdw8r1r6S0nHPQ9cs?=
 =?iso-8859-1?Q?ayHnz1w8UY/yvKEa2TiaJQtSZzGI+WEdnnWaJveHsIn9il8brIMdsiZoQY?=
 =?iso-8859-1?Q?FWcHQdV2AcyyiuxAWaoC1XEgkbBx5JmqBvO34WhO267MY2ffsSOTD9/DQI?=
 =?iso-8859-1?Q?BCsabm5/I2p4wl93gu9ttG4VOHviNjsV9v6kcl/ciUPAjGvJewcGHLQDSx?=
 =?iso-8859-1?Q?e5tQ3yZFQRfYHLR0dXi3uboD6zqGpXzYBfez/Gcrx7QytaAtYOyXa9d+xV?=
 =?iso-8859-1?Q?MhzbQWZLA+bUOfVxfOEc+jxxPSwa83nTszP7VNhai/fjScwEQMACO8T+dx?=
 =?iso-8859-1?Q?1kBYNZHEfLibWkfo5tQfQKdexRtvAp1n6rH+e8Fde+2qhVLMtS8OHGuv/H?=
 =?iso-8859-1?Q?yHlmjiRCUfuSqvQj/jWA+gU9VswpnAOdY7KhpIzK7h5xQ11ZoRpU6fup9l?=
 =?iso-8859-1?Q?wr63PYCqpf8z5HdBrl2j1eQDd39z5vDsO0qlGukCHg8SuNM23r5yF9F2yK?=
 =?iso-8859-1?Q?UQDylkqVvGa5GyPM+so0auvwb+o0vtBLUpfhxnCWAL2mdzS6KrN0JG826x?=
 =?iso-8859-1?Q?YjH7oX/Y8oTYbXNxDheIqYuZol3E3LnWmCitR0Q9OgOkEK2pDBln6f82kM?=
 =?iso-8859-1?Q?P6kW36DoQN2TWi4oTVsIc05HcR2OhAD5iP5yw3fVTuAzB6jrl3gzDPjqHl?=
 =?iso-8859-1?Q?dv1zjZ5Um/vQbzDe6JIHWB2CcD4HANLNXCj7ilCpyyZF7k1qhhtUodoK/0?=
 =?iso-8859-1?Q?VmrUw2ug8a6tq4wbwMjbx4ZQVn8U9aXctvqkOg4paNzEiASC2K8N2HFbfa?=
 =?iso-8859-1?Q?npALRHtLryoRNQeOyXHJ3nhRCGWm634Ixcpzx+5alQyFnFnB6mNkF7Hw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/alternative;
        boundary="_000_FR0P281MB196633E4F8E1195086E2402B97C49FR0P281MB1966DEUP_"
MIME-Version: 1.0
X-OriginatorOrg: janztec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c21210d0-4d90-480f-e64a-08dafa1b7699
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 12:48:28.6577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c1dae847-7bcf-493f-b143-af65743cbb23
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u91aoappzfgeUjx3qEcBayxYpVYuxVgdSV0qaO/BQ2cJZkO5trZyAu0zg7FQAl8OHuh7QBa57QC5L64POZWHfF0OhQ5C/5DXZtOd4kSZYqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1639
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: AW: mcp251xfd: rx frame truncation (1/2)
X-PTX-Original-Recipient: mkl@pengutronix.de
X-PTX-Original-Recipient: ptx@kleine-budde.de
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

I'm having some email issues, so I'm not sure what actually left the buildi=
ng. So I re-send to you directly.


> Is that something deliberately limited in your DT or where does that come=
 from?

On our CM4 baseboard there is also a UART on SPI6. So we limited the speed =
in the CAN dts to 10MHz. At the
time when I noticed the error, the overlay for the UART was not installed, =
so it should not be active at all.

> ./sctest -b -l 990 -v cmperr,logmsg -F refilldata,lessdots,stoponerror,ra=
ndomize -d 64 -n 10 -t 3 can0 can1

yes

> CRC errors are very rare in a non-noisy environment.

As they do not appear, I'm quite confident that my wireing/layout is ok.

Update:
I moved my click boards to the standard RPI and attached the logic analyzer=
. The same spi0/spi6 16/10 MHz setup.
However the truncation error has not appeared within 16h. Nevertheless I se=
e lots of Transmit Event
issues:

Jan 19 04:17:52 raspberrypi kernel: [43155.280967] mcp251xfd spi6.0 can1: T=
ransmit Event FIFO buffer not empty. (seq=3D0x000018aa, tef_tail=3D0x000018=
ae, tef_head=3D0x000018af, tx_head=3D0x000018af).
Jan 19 04:18:38 raspberrypi kernel: [43200.859040] mcp251xfd spi6.0 can1: T=
ransmit Event FIFO buffer full. (seq=3D0x00000d42, tef_tail=3D0x00000d46, t=
ef_head=3D0x00000d47, tx_head=3D0x00000d47).
Jan 19 04:48:04 raspberrypi kernel: [44967.518028] mcp251xfd spi0.0 can0: T=
ransmit Event FIFO buffer not empty. (seq=3D0x000000ae, tef_tail=3D0x000000=
b2, tef_head=3D0x000000b3, tx_head=3D0x000000b3).
Jan 19 04:49:03 raspberrypi kernel: [45026.114903] mcp251xfd spi0.0 can0: T=
ransmit Event FIFO buffer not empty. (seq=3D0x000015b0, tef_tail=3D0x000015=
b4, tef_head=3D0x000015b5, tx_head=3D0x000015b5).
Jan 19 04:51:22 raspberrypi kernel: [45165.012206] mcp251xfd spi6.0 can1: T=
ransmit Event FIFO buffer not empty. (seq=3D0x00000e12, tef_tail=3D0x00000e=
16, tef_head=3D0x00000e17, tx_head=3D0x00000e18).
Jan 19 05:13:33 raspberrypi kernel: [46496.222321] mcp251xfd spi0.0 can0: T=
ransmit Event FIFO buffer not empty. (seq=3D0x00001c3e, tef_tail=3D0x00001c=
42, tef_head=3D0x00001c43, tx_head=3D0x00001c43).
Jan 19 05:34:52 raspberrypi kernel: [47775.805160] mcp251xfd spi0.0 can0: T=
ransmit Event FIFO buffer not empty. (seq=3D0x0000244e, tef_tail=3D0x000024=
52, tef_head=3D0x00002453, tx_head=3D0x00002453).
Jan 19 06:04:57 raspberrypi kernel: [49580.850626] mcp251xfd spi0.0 can0: T=
ransmit Event FIFO buffer not empty. (seq=3D0x0000103a, tef_tail=3D0x000010=
3e, tef_head=3D0x0000103f, tx_head=3D0x0000103f).
Jan 19 06:28:33 raspberrypi kernel: [50996.403445] mcp251xfd spi6.0 can1: T=
ransmit Event FIFO buffer full. (seq=3D0x00001ed6, tef_tail=3D0x00001eda, t=
ef_head=3D0x00001edb, tx_head=3D0x00001edb).
Jan 19 06:30:13 raspberrypi kernel: [51096.376812] mcp251xfd spi0.0 can0: T=
ransmit Event FIFO buffer not empty. (seq=3D0x0000104e, tef_tail=3D0x000010=
52, tef_head=3D0x00001053, tx_head=3D0x00001053).
Jan 19 06:51:24 raspberrypi kernel: [52367.751181] mcp251xfd spi6.0 can1: T=
ransmit Event FIFO buffer not empty. (seq=3D0x000020aa, tef_tail=3D0x000020=
ae, tef_head=3D0x000020af, tx_head=3D0x000020af).
Jan 19 06:51:24 raspberrypi kernel: [52367.751459] mcp251xfd spi6.0 can1: T=
ransmit Event FIFO buffer not empty. (seq=3D0x000020ab, tef_tail=3D0x000020=
af, tef_head=3D0x000020b1, tx_head=3D0x000020b2).
Jan 19 07:27:37 raspberrypi kernel: [54540.514853] mcp251xfd spi0.0 can0: T=
ransmit Event FIFO buffer not empty. (seq=3D0x000014fe, tef_tail=3D0x000015=
02, tef_head=3D0x00001503, tx_head=3D0x00001503).
Jan 19 07:36:59 raspberrypi kernel: [55102.928987] mcp251xfd spi6.0 can1: T=
ransmit Event FIFO buffer not empty. (seq=3D0x000003aa, tef_tail=3D0x000003=
ae, tef_head=3D0x000003af, tx_head=3D0x000003af).
Jan 19 07:38:34 raspberrypi kernel: [55197.329940] mcp251xfd spi6.0 can1: T=
ransmit Event FIFO buffer not empty. (seq=3D0x00000fb6, tef_tail=3D0x00000f=
ba, tef_head=3D0x00000fbb, tx_head=3D0x00000fbb).
Jan 19 07:55:19 raspberrypi kernel: [56202.156373] mcp251xfd spi0.0 can0: T=
ransmit Event FIFO buffer not empty. (seq=3D0x00001aa6, tef_tail=3D0x00001a=
aa, tef_head=3D0x00001aab, tx_head=3D0x00001aab).
Jan 19 07:58:12 raspberrypi kernel: [56375.706280] mcp251xfd spi0.0 can0: T=
ransmit Event FIFO buffer not empty. (seq=3D0x00000aea, tef_tail=3D0x00000a=
ee, tef_head=3D0x00000aef, tx_head=3D0x00000aef).
Jan 19 08:17:11 raspberrypi kernel: [57514.699211] mcp251xfd spi6.0 can1: T=
ransmit Event FIFO buffer not empty. (seq=3D0x000001ac, tef_tail=3D0x000001=
b0, tef_head=3D0x000001b1, tx_head=3D0x000001b1).
Jan 19 08:18:14 raspberrypi kernel: [57577.895401] mcp251xfd spi0.0 can0: T=
ransmit Event FIFO buffer not empty. (seq=3D0x00000f08, tef_tail=3D0x00000f=
0c, tef_head=3D0x00000f0d, tx_head=3D0x00000f0d).
Jan 19 08:22:15 raspberrypi kernel: [57818.229608] mcp251xfd spi0.0 can0: T=
ransmit Event FIFO buffer not empty. (seq=3D0x00000d82, tef_tail=3D0x00000d=
86, tef_head=3D0x00000d87, tx_head=3D0x00000d87).
Jan 19 08:55:53 raspberrypi kernel: [59836.704617] mcp251xfd spi6.0 can1: T=
ransmit Event FIFO buffer not empty. (seq=3D0x00001632, tef_tail=3D0x000016=
36, tef_head=3D0x00001637, tx_head=3D0x00001637).
Jan 19 08:55:53 raspberrypi kernel: [59836.704913] mcp251xfd spi6.0 can1: T=
ransmit Event FIFO buffer not empty. (seq=3D0x00001633, tef_tail=3D0x000016=
37, tef_head=3D0x00001639, tx_head=3D0x0000163a).
Jan 19 08:55:53 raspberrypi kernel: [59836.705011] mcp251xfd spi6.0 can1: T=
ransmit Event FIFO buffer not empty. (seq=3D0x00001634, tef_tail=3D0x000016=
38, tef_head=3D0x0000163a, tx_head=3D0x0000163a).
Jan 19 08:56:45 raspberrypi kernel: [59888.907279] mcp251xfd spi0.0 can0: T=
ransmit Event FIFO buffer not empty. (seq=3D0x000011de, tef_tail=3D0x000011=
e2, tef_head=3D0x000011e3, tx_head=3D0x000011e3).
Jan 19 09:13:14 raspberrypi kernel: [60877.922701] mcp251xfd spi0.0 can0: T=
ransmit Event FIFO buffer not empty. (seq=3D0x000000ea, tef_tail=3D0x000000=
ee, tef_head=3D0x000000ef, tx_head=3D0x000000ef).
Jan 19 09:44:16 raspberrypi kernel: [62739.076163] mcp251xfd spi0.0 can0: T=
ransmit Event FIFO buffer not empty. (seq=3D0x000020ac, tef_tail=3D0x000020=
b0, tef_head=3D0x000020b1, tx_head=3D0x000020b1).
Jan 19 09:47:13 raspberrypi kernel: [62916.335751] mcp251xfd spi6.0 can1: T=
ransmit Event FIFO buffer not empty. (seq=3D0x0000143e, tef_tail=3D0x000014=
42, tef_head=3D0x00001443, tx_head=3D0x00001444).
Jan 19 09:56:14 raspberrypi kernel: [63457.721406] mcp251xfd spi6.0 can1: T=
ransmit Event FIFO buffer not empty. (seq=3D0x00001808, tef_tail=3D0x000018=
0c, tef_head=3D0x0000180d, tx_head=3D0x0000180d).
Jan 19 11:12:44 raspberrypi kernel: [68047.346038] mcp251xfd spi0.0 can0: T=
ransmit Event FIFO buffer not empty. (seq=3D0x000022fe, tef_tail=3D0x000023=
02, tef_head=3D0x00002303, tx_head=3D0x00002303).
Jan 19 11:48:41 raspberrypi kernel: [70204.560171] mcp251xfd spi6.0 can1: T=
ransmit Event FIFO buffer not empty. (seq=3D0x00001ea8, tef_tail=3D0x00001e=
ac, tef_head=3D0x00001ead, tx_head=3D0x00001ead).
Jan 19 11:59:54 raspberrypi kernel: [70877.645965] mcp251xfd spi0.0 can0: T=
ransmit Event FIFO buffer not empty. (seq=3D0x00000932, tef_tail=3D0x000009=
36, tef_head=3D0x00000937, tx_head=3D0x00000938).
Jan 19 12:10:23 raspberrypi kernel: [71506.521062] mcp251xfd spi0.0 can0: T=
ransmit Event FIFO buffer not empty. (seq=3D0x0000135e, tef_tail=3D0x000013=
62, tef_head=3D0x00001363, tx_head=3D0x00001363).

Are you interrested in analyzing what's going on at those times? If so, wha=
t to do in the driver to stop operation
after the message has been issued so I can stop the analyzer and sample the=
 chip registers?

--
Stefan
