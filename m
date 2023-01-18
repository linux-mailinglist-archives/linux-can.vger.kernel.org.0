Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2887B672028
	for <lists+linux-can@lfdr.de>; Wed, 18 Jan 2023 15:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjAROvH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 18 Jan 2023 09:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjAROuj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2023 09:50:39 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA46A4C0D2
        for <linux-can@vger.kernel.org>; Wed, 18 Jan 2023 06:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674053019; x=1705589019;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=QQmcfhAhMJ76huorrfk0DGSg0QATMDiX52k4aa8C/HY=;
  b=nDZC84b3rcrqv0R5SEqvzFY987bQhcAEkhFUwJKF/2PsCCLVvMPJounK
   cWtbmfhCk43XdBYvJIMj/53FTA8xznAvrgSCPKXC2R3glKBoWmATeAIfY
   2wwJK5t5oMwPVZODI60tx0vtgqVg5dcaq36mTu906fzXjUjml3Nv1ee6j
   BQgEHan7el/eAlT995zfsOjswwi+NqEcN9M0M36ay2gE5A0gV3Ss9a6vw
   FPBiLJX3bj6nxdEc0Unxd/lXyvRtJ6vkU3fUI77dt3kFkeh6orCQaM9xU
   Mzpaitk5aLBsJS/wJ5540dELQvfUX4p7PwMRzDVy2RmBHBPXgiYku8pbc
   g==;
X-IronPort-AV: E=Sophos;i="5.97,226,1669100400"; 
   d="scan'208";a="208310777"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jan 2023 07:43:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 07:43:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 18 Jan 2023 07:43:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzI+UsMfqsekDBS0B8rM12P/qpsa+TMlBFAUMfmDtrds/KCM9iWoHJ13pBsy2lRF4NJnvtwKK3Hb2zwL83GWgPtevKN1zVK82hCfTiJHUaHsQLC08xGLFNYAZo2CxBpUmX+4TuqxToGWYOlb7Ztx21QaT/qCYN8DJxPx+Ra35aKhphXTCUIWtbDYeKOoSgLsCuyCBH8Z99rcpIHyR+oEnmwn5kOONAaEtADf7kRdLJ3SYg+Xn9rTdbuCOrvlysO/zhpjNCTDPsuCh5m7dY8so8MybwLcuPx2lWb5PFcuH6/TIgv+l/LxfNkkS8bMAgPn3QVDpazjotBS7+CRNI98dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coYRV/8f2aIBHLcvbUwsuWvZBYC0NPjv7lVXdS24qRM=;
 b=C73BJifVIY07UMyneGtdt3Zu6dTi4zeIRpfj+BLBlJCCs4jR20NXQKUj+H5TeOM4oUbZ1qlOaNQhD4KzxIwBdzHUmbOOO0PN8HLg2Mb2vNi/uN178jJtRAGfzsKGO0lXnZ/z/Axv/UOZeCKNNMAi+ZMdk6fQLIgvIerm0bq7EBmT71cRPMgZ8HL2zXJo9n44CwDw0C0byoZ5YZPeRJ5OYoqHoJW+ltUOv1uMazoimvRCn6p4iLp7MNua+wSCSCMrusec4C0kxtFReq/t+mVucntKHvpk+JaH+ayVrJJM134tmhav+08y6GeVad+HEBWbBsnM0914ieMo0Z38jfCtsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coYRV/8f2aIBHLcvbUwsuWvZBYC0NPjv7lVXdS24qRM=;
 b=M8cBrJNMa/6C2kO+KaqnJoP/qwhH5jfbhsHRE5wezQHjXvjcsHyHsQEN1UdBzFWGjqrB+XvVUo+uG4gLumdBwXaLf8CvQClDazk1L59lBfXAXJvSGSlmDiD9iU/3zVd7a/sgugV0th8p3y+9UDfc5MScNUbdKc0of20zHQCXqUc=
Received: from BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19)
 by DS7PR11MB7807.namprd11.prod.outlook.com (2603:10b6:8:e3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Wed, 18 Jan 2023 14:43:34 +0000
Received: from BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::cb80:ece0:6de6:f096]) by BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::cb80:ece0:6de6:f096%5]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 14:43:34 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <Stefan.Althoefer@janztec.com>, <linux-can@vger.kernel.org>
Subject: RE: mcp251xfd: rx frame truncation (1/2)
Thread-Topic: mcp251xfd: rx frame truncation (1/2)
Thread-Index: AQHZKz4szMq49nyLkUucW5HyhGITIq6kOILg
Date:   Wed, 18 Jan 2023 14:43:34 +0000
Message-ID: <BL3PR11MB6484911640CCC738ED799E6FFBC79@BL3PR11MB6484.namprd11.prod.outlook.com>
References: <FR0P281MB1966C774C1ED0752CCD6B80497C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966F32AD422DDD867F8C53A97C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR0P281MB1966F32AD422DDD867F8C53A97C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6484:EE_|DS7PR11MB7807:EE_
x-ms-office365-filtering-correlation-id: e80fadc7-6265-4e52-3f63-08daf9626049
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wTtOtQ77+fYWNKW3h0vbs7aQZPYKa/eTAkBLCP0DLE3hENncgRgJ1U0Kb/vg8LFY4EzTB6DBvnTpS1Kr0sj1yx5fakSnEFZjqsxtz7MT+2PlKLPFciluEZqGgbprxuoXVWH86+IoAHbO5wWjdVlp6Vzi2tXfjkCjdRBGbAj503MYqAeqjy6HVupeAYt/JLqlbUHzA0jr9swvyfEL5RQcLke5kH9JMORCCaNa2esukXxSkyoaWY8BqOflwDxcF1MvHlZvZ9IgVcTjb/VQx13Y7kGu60v4CI8trXEB1us58ah3So9RigSLvlbXvLj4kSkwMETmb00Izy7m1a4/F2HckWHA9Gsc+7aR08+la3TAEv5V0mnpO8N7vmFRETcPemX7FsN8sfDC29JV4dMdrAhQyAA3aMuIzTKVeJ5MRkRLcCE6K6WSVN2Nxj+SSEl22YURAngmQfRootwojpXrry63n1ULcDuIlpGd8RnBjauXQGpkg8KC9tH+AIJOFN9WFkZ5+yxtil6+cGKuwnIz9iOMjWxloijfF49gBBLLo3hKlSAW3+xzo99jkz6mgUJI/S96jxlgJt2+Ieq4pg1i6OHlPuJCmSKsCm2gpAsQZpyiXDsTkJPCrJKkH3IIfEy7b7aTJjTOdnl5nhJhdLirolkAZjzlj0JadF4Jb9Y5MJXHf9kI5JplqgKBA+0/x2KX7Jsdy0Dz6qrFmsP9BawJ/2Qd+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199015)(38070700005)(66556008)(2906002)(66946007)(66476007)(52536014)(8676002)(66446008)(64756008)(8936002)(55016003)(5660300002)(76116006)(38100700002)(83380400001)(122000001)(33656002)(7696005)(71200400001)(110136005)(316002)(478600001)(86362001)(41300700001)(6506007)(9686003)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tYUlhe0tt0cwFNXCMeUs86XXgNsRaVvZ/zrLyACmF3YVFUsUqP9h2U7fTs?=
 =?iso-8859-1?Q?CrNaq25WhYYzw3+k20BXK1N2sA0Yi7TqkYtTsy1iZBwFxxoelR7WmGVp7G?=
 =?iso-8859-1?Q?q3xOeL3GAB6Dx292rgwALzk7UlQafwtZ1vHUP5zTbxXTTiqG8niR3JVvjK?=
 =?iso-8859-1?Q?u8OBEv+1N09qUyAnMHtoU+RdOj5j/QpY2rqElnbbQyjxZ2JUrH8vHuinq4?=
 =?iso-8859-1?Q?Vvdy7O38cK4p0OjA6rlWmELpr5+lZQAvDxB6Al9Uzyawh3TQ9dIw92+Y+A?=
 =?iso-8859-1?Q?LNpi089KeVKjAvgWYP70sxyzp0eMMKTtpuyYxW6i9yyUDNl7G0i0gTGn+n?=
 =?iso-8859-1?Q?4oGDfRADu/t0zQaqOAt9szYauXDJuwUVg0WAUTvxTZvWdEDbA+iJcFiRcl?=
 =?iso-8859-1?Q?2BMAqvHWP12T4x4cG1IPJtSbbt24vA86j04AJP7pCUEtBjkRXIggZV5M84?=
 =?iso-8859-1?Q?yz2pSoJK5SDz5Ac7YBoUrBDQ5j/1yCDTFD5Lvz5VeHMAIUf/lNMy9xggpy?=
 =?iso-8859-1?Q?YD+UR9GwfOsn40OAPAqzXhJnQnkUtndoAomxAWpO0wn8tA29sjQeXaGx7b?=
 =?iso-8859-1?Q?UNzachOfWPWq4L/266EEQlRGyYtVKySbyKg+i1ALb06ZKLuQ160DoL8vOl?=
 =?iso-8859-1?Q?bM7sHvSp8JUsLh5PikINu5+UfyVXonX8TjlbmURQDVucCHRh/u+9/9LMx7?=
 =?iso-8859-1?Q?ysTN4ROvSy3H7rCOuNeicHuKyaHXyC2erqTT1jDXhtpeY7zk0ILFzFG66i?=
 =?iso-8859-1?Q?DeJfyXUCI50/ArWRyStgWN28htxE2ghhG0YhzIgvtBI0ZGLOn0m13MpM3B?=
 =?iso-8859-1?Q?NquhN4DrK9ZgriSxPWzMOMvP5A2qHFJeCvlhOKfVmNvGdS+SIJOMv48x3o?=
 =?iso-8859-1?Q?3qoZVD4xLmSToxXSwcDPfo8azI+cyq3uLfe7NocuaesIfgFS8tfMDNfFIU?=
 =?iso-8859-1?Q?184pIdm7IYHaQa8bUDlphr2PPSBZ5NpM2wxYDknm9VNMuXg79qZlNeYSLN?=
 =?iso-8859-1?Q?h7EJK2dCjbKi3EmAyKEiQ/gCBQ0nI+3aqiyTpstri85z/n8fiksCqSPHWS?=
 =?iso-8859-1?Q?C+Hf9hpJjWogCKRmnJO8vm8xPEM2cBkZRoeQKECe4ad77aQhD640cF4Qqr?=
 =?iso-8859-1?Q?bWgpqfHZEXXTD0JlAZIdL4+puxjwUNH++Z+OUX7Z8Bxki+gH4JAr8bsSQ6?=
 =?iso-8859-1?Q?Orcz8y+ziFnqE7QHPKEAO93j4/uEKCMeldtlpYNfnNlbtQLLHjs3c3OITR?=
 =?iso-8859-1?Q?2VfeoE4FNCK8ivw/LSGp7kEiGWjCpgqxIxKPgsPkjykJhiXy6g5qLv05An?=
 =?iso-8859-1?Q?aAK29sJZMsV2Iw2pXpMF9+Sy/N8QE/BOrVjwZUu/PavT/JK8XZRl/a7e2o?=
 =?iso-8859-1?Q?G5gS2qMjC7BheTdpmD1rA1Y6BHmFyTw0wNJtZgCCxEe+U2EGvc2M0iTpF5?=
 =?iso-8859-1?Q?EIhMgLWlzalX+KML24M1tC9ZMZgJVAkS8QNVCOF/+53cQcxH222QGBKuD3?=
 =?iso-8859-1?Q?WW7vewuanjaWCBFtcqtwZ1CNrHfnMoFOb+Ndi1KfzTDTArfffQZCJ0FALo?=
 =?iso-8859-1?Q?xLnJOtJh21vGqFO41I7y3yom2XQlhCzsZHkhl2uom1rNtdw/toOyNftr/g?=
 =?iso-8859-1?Q?U7/tHp/UUSblr27u6LIhfUyXMmA47ArD9t?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80fadc7-6265-4e52-3f63-08daf9626049
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 14:43:34.3714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zIMpfRfVZj9cwEio8Ygmx6k5+QsJNlH0hRQaLWfSjHfZDh+mvPLlUpml6YFxQahXNF33fhpCm6IFmySxQGmENytBj8YtBO2Zwa/ota6x3Z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7807
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> Jan 18 05:34:00 raspberrypi kernel: [405471.116322] mcp251xfd spi0.0 can0=
:
> Transmit Event FIFO buffer not empty. (seq=3D0x00001e36,
> tef_tail=3D0x00001e3a, tef_head=3D0x00001e3b, tx_head=3D0x00001e3b).
> Jan 18 09:36:27 raspberrypi kernel: [420017.452369] mcp251xfd spi6.0 can1=
:
> Transmit Event FIFO buffer full. (seq=3D0x00001062, tef_tail=3D0x00001066=
,
> tef_head=3D0x00001067, tx_head=3D0x00001067).
>=20
Interesting, never seen of of the full messages, but only running since ~2h=
 now.

> But now the real problem. After some time one of the socketcans is receiv=
ing
> only a truncated message:
>=20
> 1: idx    2 exp:2A5#00 02 F4 7C 7B F2 53 BD 53 84 B3 4B B7 5F AE 55 2D 88=
 13 25
> 7C D4 82 EF 85 35 9C 33 1B 7C 5B 55 91 4F D1 0D 41 24 CA 95 A9 7E E0 60 D=
D 8E
> B5 0A 16 C8 2F 92 9C B1 82 22 E6 1E 55 01 9A B0 56 2B
> 1:           rx:2A5#00 02 F4 7C 7B F2 53 BD 53 84 B3 4B B7 5F AE 55 2D 88=
 13 25
>=20
=20
> I've seen this truncation occurring several times.

How often does this happen for you?

What's your SPI speed? Do you see the errors on SPI0 and SPI6 or only one o=
f them?

Thanks,
Thomas
