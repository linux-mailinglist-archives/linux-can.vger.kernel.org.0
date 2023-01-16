Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF07F66BC90
	for <lists+linux-can@lfdr.de>; Mon, 16 Jan 2023 12:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjAPLN3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 16 Jan 2023 06:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjAPLNW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 16 Jan 2023 06:13:22 -0500
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2068.outbound.protection.outlook.com [40.107.127.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228251ABCF
        for <linux-can@vger.kernel.org>; Mon, 16 Jan 2023 03:13:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a65slGzcV9r65xBfi9eFrPQCS+3qlWYm7IgkrP/JnxWxvhOYsD2zb+BH/3ID7NoJKGORiryX8ILn7eqaxUzgnKHTZhrbEeHFzTawL4odRg8molrO+JH4imfdVtugz6dUKckkBgbRqzV87EedMXscy1Aeqti23uuV2fbNs2o6JU6WdGs09gqYOP1BRGpU6GbE8At+5g3IjAebatJ+lpwXMW0GQbFqvhZcSBGMHzf5bDGaBbnr1aYNpF7/0+vk9kU8yKIGVDwh+2Yq6P2kgAiT6iwZoEDdgMsJ+KkpttBVlLXpTXResVcSEm1nlLtv9SWBQbGTyur8lEO9Cy/ybRf5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zn05AOZuPz7wWRxI/qpMO6Y6ttJEYcrk+YxJOVOQBWs=;
 b=Wn9Ik5QdJNPk67kQ4jibpTY/KJIZWnNa+KP3eSVqBfsHOaTPDUFveJSV/OwR9E3M6yAFL+Dns5LV2Mum0qG/JXvirJYBuT9DvMJrYtdJHCiImfx4AEJGAX/rnNBkcR8hf1uO1xnA227/agJ47chZ0PcYvxh898Z4QAVpjf6yAm2dJKG/y3LyfygQRH3fLpgxCu5QQJ3YH2a3R/fVtW+JkIMpDSjmZu88c2Q5tFlBozIVr01Q6WBBkp6KR0EOaBddz4SSiY44FQyZs6I8GSdkZpKdNiFMbVqY3xTYQEpfbZxuAlrXhyxhQSbbkJ/3XJ67N/qVPSg9LOcsDWQ9NWTo4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=janztec.com; dmarc=pass action=none header.from=janztec.com;
 dkim=pass header.d=janztec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janzag.onmicrosoft.de;
 s=selector1-janzag-onmicrosoft-de;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zn05AOZuPz7wWRxI/qpMO6Y6ttJEYcrk+YxJOVOQBWs=;
 b=PrpdaSdk3G9yU/2Iokg1NSPkDlY9eWn8ZFXI/5paO2ecUaAcq4mbax7PoQWO1uHWNTpiVLko/EnKhpHUyv5PZi8XYtwCj7JChVWASh7Sa6kzPwffvu8UWaf7SRgP2nOFiKgYdNI+xuGB9sTRlXSdXRdtSgMuMK5hrkfqOefCTWA=
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:26::13)
 by FR0P281MB1513.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:82::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 11:13:18 +0000
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d76a:8be5:c810:d1ba]) by FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d76a:8be5:c810:d1ba%7]) with mapi id 15.20.6002.012; Mon, 16 Jan 2023
 11:13:18 +0000
From:   =?iso-8859-1?Q?Stefan_Alth=F6fer?= <Stefan.Althoefer@janztec.com>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: mcp251xfd diagnostic outputs
Thread-Topic: mcp251xfd diagnostic outputs
Thread-Index: AdkpmEHpRWOQFWjcTmGQ7GHYJqGrXQ==
Date:   Mon, 16 Jan 2023 11:13:18 +0000
Message-ID: <FR0P281MB1966B647014B87F9EA96E77197C19@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=janztec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB1966:EE_|FR0P281MB1513:EE_
x-ms-office365-filtering-correlation-id: 0694c915-c8f9-41f3-50d8-08daf7b2aba8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tp1EcE7LGG2/d1STz5qc76bDqUC4Qk0xoU5Jt8okD9Km7mfGMM7EHBOJm40TdyNJA7kVwjty/3bQmPmwM+A9mRvqZZffCvUXYaBOUGnIt07EySj+IyE6xGYIhvP56ZffdYQSIpcOFJsgO/S1jLsu9ViWfzGJnnabNYykwF8PxwCz9vL4sueuO/dLBn+OS8OjiL6F3ecFCeowv5bfMm2LrUIXXfzL8/xx/F0gTkq5BcsnWKQ4ZMg5Lh+JywE1u6dCDPySepyZyDeCMevYJM8MMeQId7WarJDrp/1lsCghCi1XuHGaHbRVjRcUjA2lFnijrS+aIoUkJrcZuIh6ZKrShoeKHDd7xp7rJjrl3WDv4E6b7x1qBTYbnP4Mx1D5DLNyIuJIi+mM0YkWf4qcyBwPFUVyavG3glSBJQjecjKlKAR64KV3+1+6MrosZCcFkOWfk1ccAOSr4sNh+Eft/QoqRbY3R6P4Smb/qZ9p4SS+Rf2xIKGh05wURsmJhpsHkSuCJD9JG6/URwLVkcfBAkNC7Ke2KU/176n7rVCVCq2IR6Zadv82F0X3pNVNPCbdwGZYBSGdWsWSTsdbZkZSlqB2EHPbOr36b6b7h9tMmeC/lA0zLCTGCO2avulV2XqsFnstflkD0rT9Tk2gDXOwCwFU24oKKatNr8EOyhpfJF2odCwzNCaM9buJAO/H0p1QNoxUGEGiw6qKwkA4fgY0IhcVW+nqFa5cd+4AWB40YRhBINo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39840400004)(366004)(346002)(396003)(451199015)(33656002)(7116003)(76116006)(66556008)(41300700001)(66476007)(66446008)(66946007)(186003)(9686003)(26005)(64756008)(8676002)(6916009)(86362001)(83380400001)(5660300002)(52536014)(8936002)(478600001)(71200400001)(6506007)(55016003)(316002)(7696005)(38100700002)(4744005)(2906002)(38070700005)(122000001)(200273004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?j8S0P6dtOUO2aUcg5cTYIaYMey5Z62GBYIiO38EGskJSe6+D6m8ta1kDS2?=
 =?iso-8859-1?Q?i/V0lFb+ue0hRqnfMTq78BiH4AZOK8fxGqUdnZ9rNmMEs60MCETYuEHbIu?=
 =?iso-8859-1?Q?jJgYw2P3kD1PO/3dIdlNNnMnZi/4r9uqaFniFHa+0XQfLrbjKAD5ClfoIW?=
 =?iso-8859-1?Q?tNEvpZcTI942O1AzcgryWVmnoM/7cTotxcXk3yin96HISNcz2/vOqBXAB/?=
 =?iso-8859-1?Q?nFOQfv8q5VaP1oZZI/BEl7D2j0UXzefqMRA2rPCfVLbsGOf/ymfOCAiYWr?=
 =?iso-8859-1?Q?y/tPm7YtcqgRdInt7jh649dsgt/OVFO6G9fA3BQ3aD0DeJPwdql0ZYEULR?=
 =?iso-8859-1?Q?A7g8fZT7yJZXOp4BHIULi1Iqe2oTOGglgg7bnePjTBaVsrd88o1N8L+VEA?=
 =?iso-8859-1?Q?jzsMpiuW1VrCjBhIGvBjUsg89lGFmEr2az3s34rm9qXebJLNtxld+w42nw?=
 =?iso-8859-1?Q?fuQxAeyemm+YRudD7QqtMlfvYxyW2HYza0nraIcFWYnAoixwtsY7+6izQO?=
 =?iso-8859-1?Q?atbdM5tOy3I/waG3bHQxPvLQx7nys/zAPhx2RvTzHxGtXBHe5AEFr+wA6e?=
 =?iso-8859-1?Q?WaQ/96HSGv/Fei0VOsvKcJrWLcllzpNwcobVX/QP5VCzsUy8I62ffQzgJD?=
 =?iso-8859-1?Q?0SrfURuSkZCKfQfpZxdbxoITMcE9HIy3bDBFPljCE/K4pykHYrjUA0K83S?=
 =?iso-8859-1?Q?OQfaSDXHuBug3FNULgYD5iaIyXq8AoKI51LqvYJxuDm0SqV1x7yeouzVqx?=
 =?iso-8859-1?Q?PQ1bPGt7hnTkdv9qoZspNJJ4tAfyc1DC8vy9VSXqNJ5fFoz3OTZJUEUye4?=
 =?iso-8859-1?Q?HdZPFirGiXtCYC3EDjsc0ZJd1pzxHzvhxBKDb/+DzuODIzvGEPRT8bvHmi?=
 =?iso-8859-1?Q?ZJEH1AnrbKAgh68Kc6vJWzI2ao5c7XzbHEz2+AFGXuWY4ooCHPRs4DOh2t?=
 =?iso-8859-1?Q?V6CeI7QiBjvu+cRbEHU8KBCL+UlPVzGoLEPS5oS/IQ6WpIy/CPhKARIrkV?=
 =?iso-8859-1?Q?H96cggkWeXpPRP3imHzDXWwsQqdf6ud66GzngO7KMnWeN4Vz1zF6LxzBYv?=
 =?iso-8859-1?Q?U0TjMQ/+sVFi1dGRFiLZfkbuGHL4m/AbAPwih5DLcU7rEMIUAqmVr5xhsQ?=
 =?iso-8859-1?Q?MSH3RyVy4MhPGNODVdKW0ZKQrfVxYIscZmFoW2xUkUwagit5+UVg8b/avl?=
 =?iso-8859-1?Q?zKhhXC5XkBhWieK+tg0Wf/Kl9rs86iONU43DWXaqIAoskIL7vdj3yJlyAh?=
 =?iso-8859-1?Q?OYzWrOK3Wv7WrFMO2eJ1+a9cDsl+rw2JKxrDtwuyrBkw07S8xgqVeirTWK?=
 =?iso-8859-1?Q?c3o/O0ElX8LoH+Sk6HrfbnJw6uPWu9OwoJtbXVmGAnzSeK64cHFfKrsYjE?=
 =?iso-8859-1?Q?H6X1jThzzRuzYw2FK/NIZ9FmeJAk4b4DQl/zicp1McffD4VbBP5iEgUg5F?=
 =?iso-8859-1?Q?DVrf/x2mnMYBlR7dXi5h6Vs5MATAqobhscKzNZ5XDT1Hv+9TZV2GnuvhNe?=
 =?iso-8859-1?Q?SsW3v6UIUnoNnqIGXvvMozrfmV69geRtYy0Kzo8U+LY++RHjOpZ7hVrzOy?=
 =?iso-8859-1?Q?gkhd5y/b+aGPqYY9wAhUfq5LWLZTJewIjpfJRhJB6VBVFfJ50TUTJSE2r8?=
 =?iso-8859-1?Q?l1X5pTzPVHQ3FoPRHdJuE8Cx5iUxdDHDEPNFWXwx0D7ZgdKXNBoZop6A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: janztec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0694c915-c8f9-41f3-50d8-08daf7b2aba8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 11:13:18.2208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c1dae847-7bcf-493f-b143-af65743cbb23
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a0zC00I1OVp5NQOd5HnvQ0LeAAl0st90SXp5QzROfO1ZYtw4yEmxsA7UTwh4uLIudWspHwKbM8SYWhRYxYRKLtxDaWsAfGUz8TIczZmSJXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1513
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

the driver logs this kind of annoying messages:
    Jan 14 04:10:48 raspberrypi kernel: [54876.751957] mcp251xfd spi6.0 can=
1: CRC read error at address 0x0010 (length=3D4, data=3D00 4b 01 00, CRC=3D=
0xe146) retrying.

Unless DEBUG is active, I don't think that it is justified to print every s=
ingle=20
SPI CRC issue in detail to the logs:
- The errors are due to chip errata
- You cannot deduct that you have software/hardware issue from those errors
- As you do not know how the data should have been, you cant do
  diagnostic (single-bit vs multi-bit errors or the like)

So far I have only seen these errors for access to register 0x0010 and=20
rarely for 0x0000, probably because those registers have dynamic content.

Nevertheless, diagnostic for SPI CRC errors might still be useful. I sugges=
t to add=20
driver proprietary static counters in /sys for that:
    .../can0/spi_crc_dynamic_data       (for 0x000, 0x0010)   to avoid the =
word "expected"
    .../can0/spi_crc_static_data        (for all others)

-----
Stefan=20

